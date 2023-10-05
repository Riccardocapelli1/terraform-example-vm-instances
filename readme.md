Challenge scenario
You are a cloud engineer intern for a new startup. For your first project, your new boss has tasked you with creating infrastructure in a quick and efficient manner and generating a mechanism to keep track of it for future reference and changes. You have been directed to use Terraform to complete the project.

For this project, you will use Terraform to create, deploy, and keep track of infrastructure on the startup's preferred provider, Google Cloud. You will also need to import some mismanaged instances into your configuration and fix them.

In this lab, you will use Terraform to import and create multiple VM instances, a VPC network with two subnetworks, and a firewall rule for the VPC to allow connections between the two instances. You will also create a Cloud Storage bucket to host your remote backend.

Note: At the end of every section, plan and apply your changes to allow your work to be successfully verified. Since we will be updating many terraform files in this lab make sure to use the correct file path and maintain the correct indentation.
Task 1. Create the configuration files
In Cloud Shell, create your Terraform configuration files and a directory structure that resembles the following:
main.tf
variables.tf
modules/
└── instances
    ├── instances.tf
    ├── outputs.tf
    └── variables.tf
└── storage
    ├── storage.tf
    ├── outputs.tf
    └── variables.tf
Copied!
Fill out the variables.tf files in the root directory and within the modules. Add three variables to each file: region, zone, and project_id. For their default values, use us-east1, <filled in at lab start>, and your Google Cloud Project ID.
Note: You should use these variables anywhere applicable in your resource configurations.
Add the Terraform block and the Google Provider to the main.tf file. Verify the zone argument is added along with the project and region arguments in the Google Provider block.

Initialize Terraform.

Task 2. Import infrastructure
In the Google Cloud Console, on the Navigation menu, click Compute Engine > VM Instances. Two instances named tf-instance-1 and tf-instance-2 have already been created for you.
Note: by clicking on one of the instances, you can find its Instance ID, boot disk image, and machine type. These are all necessary for writing the configurations correctly and importing them into Terraform.
Import the existing instances into the instances module. To do this, you will need to follow these steps:
First, add the module reference into the main.tf file then re-initialize Terraform.
Next, write the resource configurations in the instances.tf file to match the pre-existing instances.
Name your instances tf-instance-1 and tf-instance-2.
For the purposes of this lab, the resource configuration should be as minimal as possible. To accomplish this, you will only need to include the following additional arguments in your configuration: machine_type, boot_disk, network_interface, metadata_startup_script, and allow_stopping_for_update. For the last two arguments, use the following configuration as this will ensure you won't need to recreate it:
metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
allow_stopping_for_update = true
Copied!
Once you have written the resource configurations within the module, use the terraform import command to import them into your instances module.
Apply your changes. Note that since you did not fill out all of the arguments in the entire configuration, the apply will update the instances in-place. This is fine for lab purposes, but in a production environment, you should make sure to fill out all of the arguments correctly before importing.
Click Check my progress to verify the objective.
Import infrastructure.

Task 3. Configure a remote backend
Create a Cloud Storage bucket resource inside the storage module. For the bucket name, use Bucket Name. For the rest of the arguments, you can simply use:
location = "US"
force_destroy = true
uniform_bucket_level_access = true
Note: You can optionally add output values inside of the outputs.tf file.
Add the module reference to the main.tf file. Initialize the module and apply the changes to create the bucket using Terraform.

Configure this storage bucket as the remote backend inside the main.tf file. Be sure to use the prefix terraform/state so it can be graded successfully.

If you've written the configuration correctly, upon init, Terraform will ask whether you want to copy the existing state data to the new backend. Type yes at the prompt.

Click Check my progress to verify the objective.
Configure a remote backend.

Task 4. Modify and update infrastructure
Navigate to the instances module and modify the tf-instance-1 resource to use an e2-standard-2 machine type.

Modify the tf-instance-2 resource to use an e2-standard-2 machine type.

Add a third instance resource and name it Instance Name. For this third resource, use an e2-standard-2 machine type. Make sure to change the machine type to e2-standard-2 to all the three instances.

Initialize Terraform and apply your changes.

Note: Optionally, you can add output values from these resources in the outputs.tf file within the module.
Click Check my progress to verify the objective.
Modify and update infrastructure.

Task 5. Destroy resources
Destroy the third instance Instance Name by removing the resource from the configuration file. After removing it, initialize terraform and apply the changes.
Click Check my progress to verify the objective.
Destroy resources.

Task 6. Use a module from the Registry
In the Terraform Registry, browse to the Network Module.

Add this module to your main.tf file. Use the following configurations:

Use version 6.0.0 (different versions might cause compatibility errors).
Name the VPC VPC Name, and use a global routing mode.
Specify 2 subnets in the us-east1 region, and name them subnet-01 and subnet-02. For the subnets arguments, you just need the Name, IP, and Region.
Use the IP 10.10.10.0/24 for subnet-01, and 10.10.20.0/24 for subnet-02.
You do not need any secondary ranges or routes associated with this VPC, so you can omit them from the configuration.
Once you've written the module configuration, initialize Terraform and run an apply to create the networks.

Next, navigate to the instances.tf file and update the configuration resources to connect tf-instance-1 to subnet-01 and tf-instance-2 to subnet-02.

Note: Within the instance configuration, you will need to update the network argument to VPC Name, and then add the subnetwork argument with the correct subnet for each instance.
Click Check my progress to verify the objective.
Use a module from the Registry.

Task 7. Configure a firewall
Create a firewall rule resource in the main.tf file, and name it tf-firewall.
This firewall rule should permit the VPC Name network to allow ingress connections on all IP ranges (0.0.0.0/0) on TCP port 80.
Make sure you add the source_ranges argument with the correct IP range (0.0.0.0/0).
Initialize Terraform and apply your changes.
Note: To retrieve the required network argument, you can inspect the state and find the ID or self_link of the google_compute_network resource you created. It will be in the form projects/PROJECT_ID/global/networks/VPC Name.
Click Check my progress to verify the objective.
Configure a firewall.

Connectivity test (Optional)
After you have created a firewall rule to allow internal connections over the VPC, you can optionally run a network connectivity test.

Make sure both of your VMs are running.

Navigate to Network Intelligence > Connectivity Tests. Run a connectivity test on the two VMs to verify that they are reachable. You have now validated the connectivity between the instances!

Note: Ensure that the Network Management API is successfully enabled, if it is not, click Enable.
Your configuration settings should resemble the following:

Configuration settings page

Congratulations!
If you managed to import, create, modify, and configure the architecture within the allotted time, you've shown great competency in your Terraform skills! In this lab, you started by importing two pre-configured VMs into Terraform and creating a Cloud Storage bucket to configure your backend. You then added another instance and practiced modifying and updating the resource configurations within your modules. Lastly, you used a module from the Terraform Registry to create a VPC with two subnets, connected the instances to it, and created a firewall rule to allow connections between them.

This self-paced lab is part of the Automating Infrastructure on Google Cloud with Terraform quest.

Next steps

source = <https://www.cloudskillsboost.google/course_sessions/4974407/labs/403961>