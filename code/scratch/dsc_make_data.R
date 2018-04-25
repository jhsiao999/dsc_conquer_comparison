mae <- clean_mae(mae=mae, groupid=groupid)

sizes <- names(keep_samples)

#for (sz in sizes) {
#  for (i in 1:nrow(keep_samples[[as.character(sz)]])) {
#    message(sz, ".", i)
    L <- subset_mae(mae = mae, keep_samples = keep_samples, sz = sz, i = i,
                    imposed_condition = imposed_condition, filt = filt, impute = config$impute)
    message(nrow(L$count), " genes, ", ncol(L$count), " samples.")
    pdf(paste0(config$figfilebase, "_", demethod, exts, "_", sz, "_", i, ".pdf"))
    res[[paste0(demethod, exts, ".", sz, ".", i)]] <- get(paste0("run_", demethod))(L)
    res[[paste0(demethod, exts, ".", sz, ".", i)]][["nimp"]] <- L$nimp
    dev.off()
#  }
#}


#L <- subset_mae(mae = mae, keep_samples = keep_samples, sz = sz, i = i,
#                    imposed_condition = imposed_condition, filt = filt, impute = config$impute)
