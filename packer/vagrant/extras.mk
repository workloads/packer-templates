# toggle for enabling uploads to Vagrant Cloud
ifdef vagrant_cloud
	arg_processor_vagrant_cloud = vagrant-cloud
else
	arg_processor_vagrant_cloud =
endif

# additionally `-except` args to pass to `args_except`
extra_except_args = $(arg_processor_vagrant_cloud)