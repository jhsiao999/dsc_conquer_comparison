## r script UUID: 35941609
suppressPackageStartupMessages(library(rjson))
suppressPackageStartupMessages(library(SummarizedExperiment))
suppressPackageStartupMessages(library(survey))
dscrutils:::empty_text(c("example/make_data_subset_indices/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2.stdout", "example/make_data_subset_indices/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2.stderr"))
DSC_4616340B <- list()
input.files <- c('example/get_config/get_config_1.rds','example/make_data_clean/get_config_1_get_data_1_make_data_clean_1.rds')
for (i in 1:length(input.files)) DSC_4616340B <- dscrutils:::merge_lists(DSC_4616340B, readRDS(input.files[i]))
DSC_REPLICATE <- DSC_4616340B$DSC_DEBUG$replicate
args <- DSC_4616340B$config
data_cleaned <- DSC_4616340B$data_cleaned
sizes <- 90
TIC_4616340B <- proc.time()
set.seed(DSC_REPLICATE + 35941609)

## BEGIN DSC CORE
generate_subsets <- function(mae, groupid, keepgroups, sizes, nreps, seed) {
  suppressPackageStartupMessages(library(Biobase))
  suppressPackageStartupMessages(library(MultiAssayExperiment))
pdata <- colData(mae)
if (length(groupid) > 1) {
  pdata[, paste(groupid, collapse = ".")] <-
    as.character(interaction(as.data.frame(pdata[, groupid])))
  groupid <- paste(groupid, collapse = ".")
}
if (is.null(keepgroups))
  keepgroups <- levels(factor(pdata[, groupid]))[1:2]
keepsamples <- rownames(pdata[pdata[, groupid] %in% keepgroups, , drop = FALSE])
pdata <- droplevels(pdata[match(keepsamples, rownames(pdata)), , drop = FALSE])
condt <- as.character(pdata[, groupid])
names(condt) <- rownames(pdata)
ngroups <- nlevels(factor(condt))
message("Considering the following ", ngroups, ifelse(ngroups == 1, " group: ", " groups: "),
        paste(levels(factor(condt)), collapse = " vs "))
names(sizes) <- sizes
names(nreps) <- sizes
set.seed(seed)
if (length(unique(condt)) == 1) {
  condt <- condt[sort(sample(1:length(condt), 2 * max(sizes)))]
} else {
  condt <- condt[sort(stratsample(as.character(condt),
                                  structure(rep(max(sizes), 2),
                                            names = levels(factor(condt)))))]
}
keep_tmp <- lapply(sizes, function(sz) {
  unique(t(sapply(1:nreps[as.character(sz)], function(i) {
    if (length(unique(condt)) == 1) {
      tmpn <- names(condt)
      condt2 <- paste0(condt, ".", sample(rep(c("1", "2"), ceiling(length(condt)/2)))[1:length(condt)])
      names(condt2) <- tmpn
      ngroups <- 2
    } else {
      condt2 <- condt
    }
    smp <- names(condt2)[sort(stratsample(as.character(condt2),
                                          structure(rep(sz, ngroups),
                                                    names = levels(factor(condt2)))))]
    cdt <- condt2[smp]
    paste(smp, cdt, sep = "___")
  })))
})
keep_samples <- lapply(keep_tmp, function(w) {
  rbind(apply(w, 2, function(s) sapply(strsplit(s, "___"), .subset, 1)))})
out_condition <- lapply(keep_tmp, function(w) {
  rbind(apply(w, 2, function(s) sapply(strsplit(s, "___"), .subset, 2)))})
return(list(keep_samples = keep_samples, out_condition = out_condition))
}
 data_subset_indices <- generate_subsets(data_cleaned, args$groupid, args$keepgroups, sizes, 1, args$seed)
## END DSC CORE

saveRDS(list(data_subset_indices=data_subset_indices, DSC_DEBUG=list(time=as.list(proc.time() - TIC_4616340B), script=dscrutils:::load_script(), replicate=DSC_REPLICATE, session=toString(sessionInfo()))), 'example/make_data_subset_indices/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2.rds')
dscrutils:::rm_if_empty(c("example/make_data_subset_indices/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2.stdout", "example/make_data_subset_indices/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2.stderr"))


