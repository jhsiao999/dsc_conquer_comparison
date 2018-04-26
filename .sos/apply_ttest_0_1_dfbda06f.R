## r script UUID: 5901230
suppressPackageStartupMessages(library(edgeR))
dscrutils:::empty_text(c("example/apply_ttest/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_ttest_2.stdout", "example/apply_ttest/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_ttest_2.stderr"))
DSC_5C6ECB02 <- readRDS("example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.rds")
DSC_REPLICATE <- DSC_5C6ECB02$DSC_DEBUG$replicate
data_subset <- DSC_5C6ECB02$data_subset
TIC_5C6ECB02 <- proc.time()
set.seed(DSC_REPLICATE + 5901230)

## BEGIN DSC CORE
suppressPackageStartupMessages(library(genefilter))
run_ttest <- function(L) {
  message("t-test")
  session_info <- sessionInfo()
  timing <- system.time({
    tmm <- edgeR::calcNormFactors(L$tpm)
    tpmtmm <- edgeR::cpm(L$tpm, lib.size = tmm * colSums(L$tpm))
    logtpm <- log2(tpmtmm + 1)
    idx <- seq_len(nrow(logtpm))
    names(idx) <- rownames(logtpm)
    ttest_p <- sapply(idx, function(i) {
      t.test(logtpm[i, ] ~ L$condt)$p.value
    })
  })
  hist(ttest_p, 50)
  list(session_info = session_info,
       timing = timing,
       df = data.frame(pval = ttest_p,
                       row.names = names(ttest_p)))
}
output <- run_ttest(data_subset)
## END DSC CORE

saveRDS(list(pval=output$df$pval, timing=output$df$timing, DSC_DEBUG=list(time=as.list(proc.time() - TIC_5C6ECB02), script=dscrutils:::load_script(), replicate=DSC_REPLICATE, session=toString(sessionInfo()))), 'example/apply_ttest/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_ttest_2.rds')
dscrutils:::rm_if_empty(c("example/apply_ttest/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_ttest_2.stdout", "example/apply_ttest/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_ttest_2.stderr"))


