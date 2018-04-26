## r script UUID: 5557756
library(stats)
dscrutils:::empty_text(c("example/get_nsig/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1_get_nsig_1.stdout", "example/get_nsig/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1_get_nsig_1.stderr"))
DSC_42F7B464 <- readRDS("example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1.rds")
DSC_REPLICATE <- DSC_42F7B464$DSC_DEBUG$replicate
pval <- DSC_42F7B464$pval
TIC_42F7B464 <- proc.time()
set.seed(DSC_REPLICATE + 5557756)

## BEGIN DSC CORE
nsig <- sum(p.adjust(pval)<.05)
## END DSC CORE

saveRDS(list(nsig=nsig, DSC_DEBUG=list(time=as.list(proc.time() - TIC_42F7B464), script=dscrutils:::load_script(), replicate=DSC_REPLICATE, session=toString(sessionInfo()))), 'example/get_nsig/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1_get_nsig_1.rds')
dscrutils:::rm_if_empty(c("example/get_nsig/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1_get_nsig_1.stdout", "example/get_nsig/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1_get_nsig_1.stderr"))


