#!/usr/bin/env dsc

# This is a first example of reproducing conquer comparison code

# set configuration parameters
get_config: R(args)
   mae: data/GSE48968-GPL13112.rds
   subfile: subsets/GSE48968-GPL13112_subsets.rds
   resfilebase: results/GSE48968-GPL13112
   figfilebase: figures/diffexpression/GSE48968-GPL13112
   groupid: source_name_ch1
   keepgroups: (BMDC (1h LPS Stimulation), BMDC (4h LPS Stimulation))
   seed: 42 # not necessary in DSC
   sizes: (96, 48, 24, 12)
   nreps: (1, 5, 5, 5)
   impute: NULL
   @ALIAS: args = List()
   $config: args

# import data
get_data: R(data_raw = readRDS(args$mae))
  args: $config
#  data_file: data/GSE48968-GPL13112.rds
  $data_raw: data_raw

# clean data
make_data_clean: code/prepare_mae.R + R(data_cleaned <- clean_mae(mae=data_raw, groupid=args$groupid))
  args: $config
  data_raw: $data_raw
  $data_cleaned: data_cleaned

# make data_subset indices
make_data_subset_indices: code/generate_subsets.R + R( data_subset_indices <- generate_subsets(data_cleaned, args$groupid, args$keepgroups, sizes, 1, args$seed) )
  args: $config
  data_cleaned: $data_cleaned
  sizes: 48, 90
  $data_subset_indices: data_subset_indices

# make data subsets
make_data_subset: code/prepare_mae.R + code/make_subsets.R + R( data_subset <- make_subsets(data_subset_indices=data_subset_indices, mae=data_cleaned, nrep = 1, filt="", impute=args$impute) )
  args: $config
  data_subset_indices: $data_subset_indices
  data_cleaned: $data_cleaned
  $data_subset: data_subset

# apply methods
apply_wilcoxon: code/apply_Wilcoxon.R + R(output <- run_Wilcoxon(data_subset))
  data_subset: $data_subset
  $pval: output$df$pval
  $timing: output$df$timing

apply_ttest: code/apply_ttest.R + R(output <- run_ttest(data_subset))
  data_subset: $data_subset
  $pval: output$df$pval
  $timing: output$df$timing

apply_limmatrend: code/apply_limmatrend.R + R(output <- run_limmatrend(data_subset))
  data_subset: $data_subset
  $pval: output$df$pval
  $timing: output$df$timing

# get output results
get_nsig: R(library(stats)) + R(nsig <- sum(p.adjust(pval)<.05))
  pval: $pval
  $nsig: nsig

DSC:
  R_libs: MultiAssayExperiment, iCOBRA, rjson, SummarizedExperiment
  define:
    data: get_config * get_data * make_data_clean * make_data_subset_indices * make_data_subset
    analyze: apply_wilcoxon, apply_ttest, apply_limmatrend
    score: get_nsig
  run: data * analyze * score
  output: example
