## r script UUID: 13262997
suppressPackageStartupMessages(library(edgeR))
dscrutils:::empty_text(c("example/apply_wilcoxon/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_wilcoxon_2.stdout", "example/apply_wilcoxon/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_wilcoxon_2.stderr"))
DSC_A9EFB4B3 <- readRDS("example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.rds")
DSC_REPLICATE <- DSC_A9EFB4B3$DSC_DEBUG$replicate
data_subset <- DSC_A9EFB4B3$data_subset
TIC_A9EFB4B3 <- proc.time()
set.seed(DSC_REPLICATE + 13262997)

## BEGIN DSC CORE
run_Wilcoxon <- function(L) {
  message("Wilcoxon")
  session_info <- sessionInfo()
  timing <- system.time({
    tmm <- edgeR::calcNormFactors(L$tpm)
    tpmtmm <- edgeR::cpm(L$tpm, lib.size = tmm * colSums(L$tpm))
    idx <- 1:nrow(tpmtmm)
    names(idx) <- rownames(tpmtmm)
    wilcox_p <- sapply(idx, function(i) {
      wilcox.test(tpmtmm[i, ] ~ L$condt)$p.value
    })
  })
  hist(wilcox_p, 50)
  list(session_info = session_info,
       timing = timing,
       df = data.frame(pval = wilcox_p,
                       row.names = names(wilcox_p)))
}
output <- run_Wilcoxon(data_subset)
## END DSC CORE

saveRDS(list(pval=output$df$pval, timing=output$df$timing, DSC_DEBUG=list(time=as.list(proc.time() - TIC_A9EFB4B3), script=dscrutils:::load_script(), replicate=DSC_REPLICATE, session=toString(sessionInfo()))), 'example/apply_wilcoxon/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_wilcoxon_2.rds')
dscrutils:::rm_if_empty(c("example/apply_wilcoxon/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_wilcoxon_2.stdout", "example/apply_wilcoxon/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2_apply_wilcoxon_2.stderr"))


