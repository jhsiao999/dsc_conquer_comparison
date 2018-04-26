## r script UUID: 67083057
suppressPackageStartupMessages(library(limma))
dscrutils:::empty_text(c("example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1_apply_limmatrend_1.stdout", "example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1_apply_limmatrend_1.stderr"))
DSC_87691E20 <- readRDS("example/make_data_subset/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1.rds")
DSC_REPLICATE <- DSC_87691E20$DSC_DEBUG$replicate
data_subset <- DSC_87691E20$data_subset
TIC_87691E20 <- proc.time()
set.seed(DSC_REPLICATE + 67083057)

## BEGIN DSC CORE
suppressPackageStartupMessages(library(edgeR))
run_limmatrend <- function(L) {
  message("limmatrend")
  session_info <- sessionInfo()
  timing <- system.time({
    dge <- DGEList(L$count, group = L$condt)
    dge <- calcNormFactors(dge)
    design <- model.matrix(~L$condt)
    y <- new("EList")
    y$E <- edgeR::cpm(dge, log = TRUE, prior.count = 3)
    fit <- lmFit(y, design = design)
    fit <- eBayes(fit, trend = TRUE, robust = TRUE)
    tt <- topTable(fit, n = Inf, adjust.method = "BH")
  })
  hist(tt$P.Value, 50)
  hist(tt$adj.P.Val, 50)
  limma::plotMDS(dge, col = as.numeric(as.factor(L$condt)), pch = 19)
  plotMD(fit)
  list(session_info = session_info,
       timing = timing,
       tt = tt,
       df = data.frame(pval = tt$P.Value,
                       padj = tt$adj.P.Val,
                       row.names = rownames(tt)))
}
output <- run_limmatrend(data_subset)
## END DSC CORE

saveRDS(list(pval=output$df$pval, timing=output$df$timing, DSC_DEBUG=list(time=as.list(proc.time() - TIC_87691E20), script=dscrutils:::load_script(), replicate=DSC_REPLICATE, session=toString(sessionInfo()))), 'example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1_apply_limmatrend_1.rds')
dscrutils:::rm_if_empty(c("example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1_apply_limmatrend_1.stdout", "example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1_apply_limmatrend_1.stderr"))


