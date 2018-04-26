suppressPackageStartupMessages(library(iCOBRA))
suppressPackageStartupMessages(library(rjson))
suppressPackageStartupMessages(library(SummarizedExperiment))
suppressPackageStartupMessages(library(MultiAssayExperiment))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))
#source("scripts/prepare_mae.R")
#source("scripts/calculate_gene_characteristics.R")

## Create iCOBRA object from the result files for the different methods
#(resfiles <- paste0(resdir, "/", dataset, "_", demethods, exts, ".rds"))
#stopifnot(all(file.exists(resfiles)))

prepare_cobra <- function(input1, input2) {
  cobra <- NULL
  timings <- list()
  runstatus <- list()
#  for (rfn in resfiles) {   ## for each DE method
#    rf <- readRDS(rfn)
#    for (nm in names(rf)) {   ## for each data set instance (nm = method.ncells.repl)
#      print(names(rf[[nm]]))
#
      ## Get stored timing information and results
      timings[[nm]] <- rf[[nm]]$timing
      df <- rf[[nm]]$df

#      if (!is.null(df)) {
#        runstatus[[nm]] <- "success"
#      } else {
#        runstatus[[nm]] <- "failure"
#      }

      ## Add to iCOBRA object
      if ("pval" %in% colnames(df)) {
        cobra <- COBRAData(pval = setNames(data.frame(mt = df$pval,
                                                      row.names = rownames(df)), nm),
                           object_to_extend = cobra)
      }
#      if ("padj" %in% colnames(df)) {
#        cobra <- COBRAData(padj = setNames(data.frame(mt = df$padj,
#                                                      row.names = rownames(df)), nm),
#                           object_to_extend = cobra)
#      }
#    }
#  }

  #cobra <- calculate_adjp(cobra)
}
