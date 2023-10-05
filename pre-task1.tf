############################
############################
#        folder structure
#        
#        main.tf
#        variables.tf
#        modules/
#        └── instances
#            ├── instances.tf
#            ├── outputs.tf
#            └── variables.tf
#        └── storage
#            ├── storage.tf
#            ├── outputs.tf
#            └── variables.tf
#        
############################
############################

# mkdir -p modules/instances modules/storage && touch main.tf variables.tf modules/instances/instances.tf modules/instances/outputs.tf modules/instances/variables.tf modules/storage/storage.tf modules/storage/outputs.tf modules/storage/variables.tf

### variables.tf
variable "project_id" {
  description = "The project ID to host the network in"
  default     = "qwiklabs-gcp-01-a89a911df98f"
}
variable "region" {
  description = "The project ID to host the network in"
  default     = "us-east1"
}
