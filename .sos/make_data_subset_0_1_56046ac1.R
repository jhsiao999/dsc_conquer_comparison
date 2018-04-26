## r script UUID: 83912069
library(MultiAssayExperiment)
suppressPackageStartupMessages(library(rjson))
suppressPackageStartupMessages(library(tximport))
suppressPackageStartupMessages(library(survey))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(SummarizedExperiment))
dscrutils:::empty_text(c("example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.stdout", "example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.stderr"))
DSC_C8ABFFC0 <- list()
input.files <- c('example/get_config/get_config_1.rds','example/make_data_clean/get_config_1_get_data_1_make_data_clean_1.rds','example/make_data_subset_indices/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2.rds')
for (i in 1:length(input.files)) DSC_C8ABFFC0 <- dscrutils:::merge_lists(DSC_C8ABFFC0, readRDS(input.files[i]))
DSC_REPLICATE <- DSC_C8ABFFC0$DSC_DEBUG$replicate
args <- DSC_C8ABFFC0$config
data_cleaned <- DSC_C8ABFFC0$data_cleaned
data_subset_indices <- DSC_C8ABFFC0$data_subset_indices
TIC_C8ABFFC0 <- proc.time()
set.seed(DSC_REPLICATE + 83912069)

## BEGIN DSC CORE
impute_dropouts <- function(count, tpm, condt, avetxlength, imputationmethod) {
  if (imputationmethod == "scimpute") {
    source("scripts/scimpute_dropouts.R")
    imputed <- scimpute_dropouts(count = count, tpm = tpm, condt = condt,
                                 avetxlength = avetxlength)
  } else if (imputationmethod == "drimpute") {
    source("scripts/drimpute_dropouts.R")
    imputed <- drimpute_dropouts(count = count, tpm = tpm, condt = condt,
                                 avetxlength = avetxlength)
  } else if (imputationmethod == "knnsmooth") {
    source("scripts/knnsmooth_dropouts.R")
    imputed <- knnsmooth_dropouts(count = count, tpm = tpm, condt = condt,
                                  avetxlength = avetxlength)
  }
  imputed
}
clean_mae <- function(mae, groupid) {
  library(SummarizedExperiment)
  mae@sampleMap$assay <- factor(mae@sampleMap$assay)
  mae <- updateObject(mae)
  mae2 <- subsetByRow(mae, grep("^ERCC-", unique(unlist(rownames(mae))),
                                invert = TRUE, value = TRUE))
  for (m in names(experiments(mae2))) {
    SummarizedExperiment::assays(experiments(mae2)[[m]])[["TPM"]] <- sweep(SummarizedExperiment::assays(experiments(mae2)[[m]])[["TPM"]],
            2, colSums(SummarizedExperiment::assays(experiments(mae2)[[m]])[["TPM"]]), "/") * 1e6
  }
  if (length(groupid) > 1) {
    if (paste0(R.Version()$major, ".", R.Version()$minor) < "3.4") {
      Biobase::pData(mae2)[, paste(groupid, collapse = ".")] <-
        as.character(interaction(as.data.frame(Biobase::pData(mae2)[, groupid])))
      groupid <- paste(groupid, collapse = ".")
    } else {
      colData(mae2)[, paste(groupid, collapse = ".")] <-
        as.character(interaction(as.data.frame(colData(mae2)[, groupid])))
      groupid <- paste(groupid, collapse = ".")
    }
  }
  mae2
}
subset_mae <- function(mae, keep_samples, sz, i, imposed_condition, filt,
                       groupid = NULL, impute = NULL) {
  mae@sampleMap$assay <- factor(mae@sampleMap$assay)
  mae <- updateObject(mae)
  s <- keep_samples[[as.character(sz)]][i, ]
  count <- assays(experiments(mae)[["gene"]])[["count_lstpm"]][, s]
  tpm <- assays(experiments(mae)[["gene"]])[["TPM"]][, s]
  avetxlength = assays(experiments(mae)[["gene"]])[["avetxlength"]]
  if (!is.null(imposed_condition)) {
    if (paste0(R.Version()$major, ".", R.Version()$minor) < "3.4") {
      condt <- structure(imposed_condition[[as.character(sz)]][i, ],
                         names = rownames(Biobase::pData(mae)[s, ]))
    } else {
      condt <- structure(imposed_condition[[as.character(sz)]][i, ],
                         names = rownames(colData(mae)[s, ]))
    }
  } else {
    if (is.null(groupid)) stop("Must provide groupid")
    if (paste0(R.Version()$major, ".", R.Version()$minor) < "3.4") {
      condt <- structure(as.character(Biobase::pData(mae)[s, groupid]),
                         names = rownames(Biobase::pData(mae)[s, ]))
    } else {
      condt <- structure(as.character(colData(mae)[s, groupid]),
                         names = rownames(colData(mae)[s, ]))
    }
  }
  if (!is.null(impute) && impute != "no" && !is.na(impute)) {
    imputed <- impute_dropouts(count = count, tpm = tpm, condt = condt,
                               avetxlength = avetxlength,
                               imputationmethod = impute)
    count <- imputed$count
    tpm <- imputed$tpm
    condt <- imputed$condt
    nimp <- imputed$nimp  ## number of imputed values
  } else {
    nimp <- NULL
  }
  if (filt == "") {
    count <- count[rowSums(count) > 0, ]
    tpm <- tpm[rowSums(tpm) > 0, ]
  } else {
    filt <- strsplit(filt, "_")[[1]]
    if (substr(filt[3], nchar(filt[3]), nchar(filt[3])) == "p") {
      (nbr <- as.numeric(gsub("p", "", filt[3]))/100 * ncol(count))
    } else {
      (nbr <- as.numeric(filt[3]))
    }
    if (filt[1] == "count") {
      keep_rows <- rownames(count)[which(rowSums(count > as.numeric(filt[2]))
                                         > nbr)]
    } else if (filt[1] == "TPM") {
      keep_rows <- rownames(tpm)[which(rowSums(tpm > as.numeric(filt[2]))
                                       > nbr)]
    } else {
      stop("First element of filt must be 'count' or 'TPM'.")
    }
    count <- count[match(keep_rows, rownames(count)), ]
    tpm <- tpm[match(keep_rows, rownames(tpm)), ]
  }
  stopifnot(all(names(condt) == colnames(count)))
  stopifnot(all(names(condt) == colnames(tpm)))
  stopifnot(length(unique(condt)) == 2)
  summary(colSums(count))
  summary(rowSums(count))
  summary(rowSums(tpm))
  if (!is.null(nimp)) {
    nimp <- nimp[match(rownames(count), rownames(nimp)), ]
  }
  list(count = count, tpm = tpm, condt = condt, nimp = nimp)
}
suppressPackageStartupMessages(library(reshape2))
suppressPackageStartupMessages(library(GEOquery))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(Biobase))
suppressPackageStartupMessages(library(MultiAssayExperiment))
make_subsets <- function(data_subset_indices, mae, nrep = 1, filt="", impute) {
  keep_samples <- data_subset_indices$keep_samples
  imposed_condition <- data_subset_indices$out_condition
  sz <- as.numeric(names(keep_samples)[1])
  L <- subset_mae(mae = mae, keep_samples = keep_samples, sz = sz, i = nrep,
                  imposed_condition = imposed_condition, filt = filt, impute = impute)
  return(L)
}
 data_subset <- make_subsets(data_subset_indices=data_subset_indices, mae=data_cleaned, nrep = 1, filt="", impute=args$impute)
## END DSC CORE

saveRDS(list(data_subset=data_subset, DSC_DEBUG=list(time=as.list(proc.time() - TIC_C8ABFFC0), script=dscrutils:::load_script(), replicate=DSC_REPLICATE, session=toString(sessionInfo()))), 'example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.rds')
dscrutils:::rm_if_empty(c("example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.stdout", "example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.stderr"))


