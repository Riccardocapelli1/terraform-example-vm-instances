
# command line terraform network test

gcloud beta network-management connectivity-tests create terraform-network-check --destination-instance=projects/qwiklabs-gcp-01-a89a911df98f/zones/us-east1-c/instances/tf-instance-2 --destination-network=projects/qwiklabs-gcp-01-a89a911df98f/global/networks/tf-vpc-620528 --destination-port=80 --protocol=TCP --source-instance=projects/qwiklabs-gcp-01-a89a911df98f/zones/us-east1-c/instances/tf-instance-1 --source-network=projects/qwiklabs-gcp-01-a89a911df98f/global/networks/tf-vpc-620528 --project=qwiklabs-gcp-01-a89a911df98f

