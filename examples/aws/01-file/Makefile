
init:
	# When using a module with s3 backend you need to specify where to store the statefile:
	# -backend-config=key=tf-example-state/terraform.tfstate
	# Do not overwrite TF_CLI_ARGS_init to use default backend options
	TF_CLI_ARGS_init='' terraform init
	mkdir -p ./dist

plan:
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy

clean:
	rm -rf .terraform *.tfstate*
	rm -rf ./dist