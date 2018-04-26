# workflow: apply_limmatrend
# script: /Users/joycehsiao/Dropbox/GitHub/dsc_conquer_comparison/.sos/c9096a33.sos
# included: 
# configuration: /Users/joycehsiao/Dropbox/GitHub/dsc_conquer_comparison/.sos/.dsc/example.conf.yml
# start time: Thu, 26 Apr 2018 01:08:40 +0000
# Sections
apply_limmatrend_0: 161b81565fbf2db1
get_config: 9a9094063834288d
get_data: 2d65980300a00a77
make_data_clean: 989d815d2ee2514d
make_data_subset_indices: 16d4a4775e0cd276
make_data_subset: d7bf2d64ed8477a6
apply_wilcoxon: 83bdd1b143a02fb7
get_nsig: 75908164bc1002ac
apply_ttest: 0640b8dae500ddb5
apply_limmatrend: 161b81565fbf2db1
a_get_config: 0b8fcde6920e7089
a_get_data: 6407c1098e145d5d
a_make_data_clean: 430c6644b5584728
a_make_data_subset_indices: 33a4ca04baf98291
a_make_data_subset: 4ac3132765065757
a_apply_wilcoxon: eaed444733f3ea06
a_get_nsig: 632c367c45a50fea
b_apply_ttest: a363cfc41e3cb9e5
b_get_nsig: bda93774ef954bf4
c_apply_limmatrend: b180925c719d76a8
c_get_nsig: 5c3d321f8639ac01
DSC: 7bb013b139a05b95
# Command line options
{'apply_limmatrend_output_files': ['example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1_apply_limmatrend_1.rds', 'example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1.rds'], 'apply_limmatrend_input_files': ['example/make_data_subset/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1.rds', 'example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.rds'], 'DSC_STEP_ID_': 67083057, '__args__': []}
# runtime signatures
EXE_SIG	step=161b81565fbf2db1	session=281c7a311d6500da
IN_FILE	filename=example/make_data_subset/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1.rds	session=161b81565fbf2db1	size=15632395	md5=a6ac008940365087
OUT_FILE	filename=example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_1_make_data_subset_1_apply_limmatrend_1.rds	session=161b81565fbf2db1	size=192020	md5=1ea0e266d191af0b
EXE_SIG	step=161b81565fbf2db1	session=4832368d4109e79c
IN_FILE	filename=example/make_data_subset/get_config_2_get_data_2_make_data_clean_2_make_data_subset_indices_2_make_data_subset_2.rds	session=161b81565fbf2db1	size=29600629	md5=6674e4d7d7569536
OUT_FILE	filename=example/apply_limmatrend/get_config_1_get_data_1_make_data_clean_1_make_data_subset_indices_2_make_data_subset_1_apply_limmatrend_1.rds	session=161b81565fbf2db1	size=215168	md5=4cde88abd8df15b0
# end time: Thu, 26 Apr 2018 01:09:22 +0000
# input and dependent files
