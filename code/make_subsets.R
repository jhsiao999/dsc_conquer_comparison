suppressPackageStartupMessages(library(rjson))
suppressPackageStartupMessages(library(reshape2))
suppressPackageStartupMessages(library(tximport))
suppressPackageStartupMessages(library(GEOquery))
suppressPackageStartupMessages(library(survey))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(Biobase))
suppressPackageStartupMessages(library(SummarizedExperiment))
suppressPackageStartupMessages(library(MultiAssayExperiment))

make_subsets <- function(data_subset_indices, mae, nrep = 1, filt="", impute) {
  keep_samples <- data_subset_indices$keep_samples
  imposed_condition <- data_subset_indices$out_condition
  sz <- as.numeric(names(keep_samples)[1])

  L <- subset_mae(mae = mae, keep_samples = keep_samples, sz = sz, i = nrep,
                  imposed_condition = imposed_condition, filt = filt, impute = impute)
  return(L)
}
