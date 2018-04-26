import msgpack
from collections import OrderedDict
from dsc.utils import sos_hash_output, sos_group_input, chunks
## 1:
##   apply_wilcoxon: !!python/tuple [apply_wilcoxon, 1]
##   get_config: !!python/tuple [get_config, 1]
##   get_data: !!python/tuple [get_data, 1]
##   get_nsig: !!python/tuple [get_nsig, 1]
##   make_data_clean: !!python/tuple [make_data_clean, 1]
##   make_data_subset: !!python/tuple [make_data_subset, 1]
##   make_data_subset_indices: !!python/tuple [make_data_subset_indices, 1]
## 2:
##   apply_ttest: !!python/tuple [apply_ttest, 2]
##   get_config: !!python/tuple [get_config, 1]
##   get_data: !!python/tuple [get_data, 1]
##   get_nsig: !!python/tuple [get_nsig, 2]
##   make_data_clean: !!python/tuple [make_data_clean, 1]
##   make_data_subset: !!python/tuple [make_data_subset, 1]
##   make_data_subset_indices: !!python/tuple [make_data_subset_indices, 1]
## 3:
##   apply_limmatrend: !!python/tuple [apply_limmatrend, 3]
##   get_config: !!python/tuple [get_config, 1]
##   get_data: !!python/tuple [get_data, 1]
##   get_nsig: !!python/tuple [get_nsig, 3]
##   make_data_clean: !!python/tuple [make_data_clean, 1]
##   make_data_subset: !!python/tuple [make_data_subset, 1]
##   make_data_subset_indices: !!python/tuple [make_data_subset_indices, 1]
## @profile #via "kernprof -l" and "python -m line_profiler"
def prepare_io():

	__io_db__ = OrderedDict()
	###
	# [A]
	###
	__pipeline_id__ = '1'
	__pipeline_name__ = 'a_get_config+a_get_data+a_make_data_clean+a_make_data_subset_indices+a_make_data_subset+a_apply_wilcoxon+a_get_nsig'
	# output: '.sos/.dsc/example_1.mpk'

	## Codes for get_config
	__out_vars__ = ['config']
	mae = ["'data/GSE48968-GPL13112.rds'"]
	subfile = ["'subsets/GSE48968-GPL13112_subsets.rds'"]
	resfilebase = ["'results/GSE48968-GPL13112'"]
	figfilebase = ["'figures/diffexpression/GSE48968-GPL13112'"]
	groupid = ["'source_name_ch1'"]
	keepgroups = ["list('BMDC (1h LPS Stimulation)','BMDC (4h LPS Stimulation)')"]
	seed = [42]
	sizes = ['c(96,48,24,12)']
	nreps = ['c(1,5,5,5)']
	impute = ['NULL']
	DSC_REPLICATE = [1]
	__a_get_config_output__ = sos_hash_output(['get_config  DSC_REPLICATE:{} impute:{} nreps:{} sizes:{} seed:{} keepgroups:{} groupid:{} figfilebase:{} resfilebase:{} subfile:{} mae:{}'.format(_DSC_REPLICATE, _impute, _nreps, _sizes, _seed, _keepgroups, _groupid, _figfilebase, _resfilebase, _subfile, _mae) for _DSC_REPLICATE in DSC_REPLICATE for _impute in impute for _nreps in nreps for _sizes in sizes for _seed in seed for _keepgroups in keepgroups for _groupid in groupid for _figfilebase in figfilebase for _resfilebase in resfilebase for _subfile in subfile for _mae in mae])
	__a_get_config_output__ = ['get_config:{}'.format(item) for item in __a_get_config_output__]
	__io_db__['get_config:' + str(__pipeline_id__)] = dict([(y, dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'get_config'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([('DSC_REPLICATE', _DSC_REPLICATE), ('impute', _impute), ('nreps', _nreps), ('sizes', _sizes), ('seed', _seed), ('keepgroups', _keepgroups), ('groupid', _groupid), ('figfilebase', _figfilebase), ('resfilebase', _resfilebase), ('subfile', _subfile), ('mae', _mae)], None) for _DSC_REPLICATE in DSC_REPLICATE for _impute in impute for _nreps in nreps for _sizes in sizes for _seed in seed for _keepgroups in keepgroups for _groupid in groupid for _figfilebase in figfilebase for _resfilebase in resfilebase for _subfile in subfile for _mae in mae ], __a_get_config_output__)] + [('__input_output___', ([], __a_get_config_output__)), ('__ext__', 'rds')])

	## Codes for get_data
	__out_vars__ = ['data_raw']
	## With variables from: get_config
	__a_get_data_output__ = sos_hash_output(['get_data ' ])
	__a_get_data_output__ = ['get_data:{}:{}'.format(item, __i__) for item in __a_get_data_output__ for __i__ in __a_get_config_output__]
	__io_db__['get_data:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'get_data'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f'{__i__}')  for __i__ in __a_get_config_output__], __a_get_data_output__)] + [('__input_output___', (__a_get_config_output__ if __a_get_config_output__ is not None else [], __a_get_data_output__)), ('__ext__', 'rds')])

	## Codes for make_data_clean
	__out_vars__ = ['data_cleaned']
	## With variables from: get_config, get_data
	__a_make_data_clean_input__ = sos_group_input(__a_get_config_output__, __a_get_data_output__)
	__a_make_data_clean_output__ = sos_hash_output(['make_data_clean  code/prepare_mae.R' ])
	__a_make_data_clean_output__ = ['make_data_clean:{}:{}'.format(item, ':'.join(__i__)) for item in __a_make_data_clean_output__ for __i__ in chunks(__a_make_data_clean_input__, 2)]
	__io_db__['make_data_clean:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'make_data_clean'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f"{' '.join(__i__)}")  for __i__ in chunks(__a_make_data_clean_input__, 2)], __a_make_data_clean_output__)] + [('__input_output___', (__a_make_data_clean_input__ if __a_make_data_clean_input__ is not None else [], __a_make_data_clean_output__)), ('__ext__', 'rds')])

	## Codes for make_data_subset_indices
	__out_vars__ = ['data_subset_indices']
	sizes = [48, 90]
	## With variables from: get_config, make_data_clean
	__a_make_data_subset_indices_input__ = sos_group_input(__a_get_config_output__, __a_make_data_clean_output__)
	__a_make_data_subset_indices_output__ = sos_hash_output(['make_data_subset_indices  code/generate_subsets.R sizes:{}'.format(_sizes) for _sizes in sizes])
	__a_make_data_subset_indices_output__ = ['make_data_subset_indices:{}:{}'.format(item, ':'.join(__i__)) for item in __a_make_data_subset_indices_output__ for __i__ in chunks(__a_make_data_subset_indices_input__, 2)]
	__io_db__['make_data_subset_indices:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'make_data_subset_indices'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([('sizes', _sizes)], f"{' '.join(__i__)}") for _sizes in sizes for __i__ in chunks(__a_make_data_subset_indices_input__, 2)], __a_make_data_subset_indices_output__)] + [('__input_output___', (__a_make_data_subset_indices_input__ if __a_make_data_subset_indices_input__ is not None else [], __a_make_data_subset_indices_output__)), ('__ext__', 'rds')])

	## Codes for make_data_subset
	__out_vars__ = ['data_subset']
	## With variables from: get_config, make_data_clean, make_data_subset_indices
	__a_make_data_subset_input__ = sos_group_input(__a_get_config_output__, __a_make_data_clean_output__, __a_make_data_subset_indices_output__)
	__a_make_data_subset_output__ = sos_hash_output(['make_data_subset  code/prepare_mae.R code/make_subsets.R' ])
	__a_make_data_subset_output__ = ['make_data_subset:{}:{}'.format(item, ':'.join(__i__)) for item in __a_make_data_subset_output__ for __i__ in chunks(__a_make_data_subset_input__, 3)]
	__io_db__['make_data_subset:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'make_data_subset'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f"{' '.join(__i__)}")  for __i__ in chunks(__a_make_data_subset_input__, 3)], __a_make_data_subset_output__)] + [('__input_output___', (__a_make_data_subset_input__ if __a_make_data_subset_input__ is not None else [], __a_make_data_subset_output__)), ('__ext__', 'rds')])

	## Codes for apply_wilcoxon
	__out_vars__ = ['pval', 'timing']
	## With variables from: make_data_subset
	__a_apply_wilcoxon_output__ = sos_hash_output(['apply_wilcoxon  code/apply_Wilcoxon.R' ])
	__a_apply_wilcoxon_output__ = ['apply_wilcoxon:{}:{}'.format(item, __i__) for item in __a_apply_wilcoxon_output__ for __i__ in __a_make_data_subset_output__]
	__io_db__['apply_wilcoxon:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'apply_wilcoxon'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f'{__i__}')  for __i__ in __a_make_data_subset_output__], __a_apply_wilcoxon_output__)] + [('__input_output___', (__a_make_data_subset_output__ if __a_make_data_subset_output__ is not None else [], __a_apply_wilcoxon_output__)), ('__ext__', 'rds')])

	## Codes for get_nsig
	__out_vars__ = ['nsig']
	## With variables from: apply_wilcoxon
	__a_get_nsig_output__ = sos_hash_output(['get_nsig ' ])
	__a_get_nsig_output__ = ['get_nsig:{}:{}'.format(item, __i__) for item in __a_get_nsig_output__ for __i__ in __a_apply_wilcoxon_output__]
	__io_db__['get_nsig:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'get_nsig'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f'{__i__}')  for __i__ in __a_apply_wilcoxon_output__], __a_get_nsig_output__)] + [('__input_output___', (__a_apply_wilcoxon_output__ if __a_apply_wilcoxon_output__ is not None else [], __a_get_nsig_output__)), ('__ext__', 'rds')])

	###
	# [B]
	###
	__pipeline_id__ = '2'
	__pipeline_name__ = 'a_get_config+a_get_data+a_make_data_clean+a_make_data_subset_indices+a_make_data_subset+b_apply_ttest+b_get_nsig'
	# output: '.sos/.dsc/example_2.mpk'

	## Codes for apply_ttest
	__out_vars__ = ['pval', 'timing']
	## With variables from: make_data_subset
	__b_apply_ttest_output__ = sos_hash_output(['apply_ttest  code/apply_ttest.R' ])
	__b_apply_ttest_output__ = ['apply_ttest:{}:{}'.format(item, __i__) for item in __b_apply_ttest_output__ for __i__ in __a_make_data_subset_output__]
	__io_db__['apply_ttest:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'apply_ttest'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f'{__i__}')  for __i__ in __a_make_data_subset_output__], __b_apply_ttest_output__)] + [('__input_output___', (__a_make_data_subset_output__ if __a_make_data_subset_output__ is not None else [], __b_apply_ttest_output__)), ('__ext__', 'rds')])

	## Codes for get_nsig
	__out_vars__ = ['nsig']
	## With variables from: apply_ttest
	__b_get_nsig_output__ = sos_hash_output(['get_nsig ' ])
	__b_get_nsig_output__ = ['get_nsig:{}:{}'.format(item, __i__) for item in __b_get_nsig_output__ for __i__ in __b_apply_ttest_output__]
	__io_db__['get_nsig:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'get_nsig'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f'{__i__}')  for __i__ in __b_apply_ttest_output__], __b_get_nsig_output__)] + [('__input_output___', (__b_apply_ttest_output__ if __b_apply_ttest_output__ is not None else [], __b_get_nsig_output__)), ('__ext__', 'rds')])

	###
	# [C]
	###
	__pipeline_id__ = '3'
	__pipeline_name__ = 'a_get_config+a_get_data+a_make_data_clean+a_make_data_subset_indices+a_make_data_subset+c_apply_limmatrend+c_get_nsig'
	# output: '.sos/.dsc/example_3.mpk'

	## Codes for apply_limmatrend
	__out_vars__ = ['pval', 'timing']
	## With variables from: make_data_subset
	__c_apply_limmatrend_output__ = sos_hash_output(['apply_limmatrend  code/apply_limmatrend.R' ])
	__c_apply_limmatrend_output__ = ['apply_limmatrend:{}:{}'.format(item, __i__) for item in __c_apply_limmatrend_output__ for __i__ in __a_make_data_subset_output__]
	__io_db__['apply_limmatrend:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'apply_limmatrend'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f'{__i__}')  for __i__ in __a_make_data_subset_output__], __c_apply_limmatrend_output__)] + [('__input_output___', (__a_make_data_subset_output__ if __a_make_data_subset_output__ is not None else [], __c_apply_limmatrend_output__)), ('__ext__', 'rds')])

	## Codes for get_nsig
	__out_vars__ = ['nsig']
	## With variables from: apply_limmatrend
	__c_get_nsig_output__ = sos_hash_output(['get_nsig ' ])
	__c_get_nsig_output__ = ['get_nsig:{}:{}'.format(item, __i__) for item in __c_get_nsig_output__ for __i__ in __c_apply_limmatrend_output__]
	__io_db__['get_nsig:' + str(__pipeline_id__)] = dict([(' '.join((y, x[1])), dict([('__pipeline_id__', __pipeline_id__), ('__pipeline_name__', __pipeline_name__), ('__module__', 'get_nsig'), ('__out_vars__', __out_vars__)] + x[0])) for x, y in zip([([], f'{__i__}')  for __i__ in __c_apply_limmatrend_output__], __c_get_nsig_output__)] + [('__input_output___', (__c_apply_limmatrend_output__ if __c_apply_limmatrend_output__ is not None else [], __c_get_nsig_output__)), ('__ext__', 'rds')])

	open('.sos/.dsc/example.io.mpk', 'wb').write(msgpack.packb(__io_db__))

if __name__ == '__main__':
	prepare_io()

