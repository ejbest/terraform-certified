<h1>Terraform Study Points</h1>

1. In order to check the current version of Terraform you have installed, you can use the command __

- terraform version 

2. The command __ can be used to ensure your code is syntactically valid and internally consistent.

- terraform validate

3. To skip the refresh step during a terraform apply, you can use the command __

- terraform apply -refresh=false

4. By default, Terraform stores its state in a file named __

- terraform .tfstate

5. You can use the command __ to reformat your configuration files in the standard canonical style for HCL.

- terraform fmt

6. To automatically apply changes without interactive confirmation, you can use the command __

terraform apply -auto-approve

7. What command can be used to perform a dry-run of your changes and save the proposed changes to a file named bryan for future use? __

terraform plan -out=bryan

8. You need to access the attributes of a data source in your Terraform configuration for the following code. How should you reference the ID of the returned data? __ 
<pre>
data "aws_ami" "ubuntu" {
  most_recent = true
 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
 
  owners = ["099720109477"] 
}</pre>

- data.aws_ami.ubuntu.id

- The expression data.aws_ami.ubuntu.id is used in Terraform to refer to the ID of an Amazon Machine Image (AMI) for Ubuntu retrieved from the AWS data source named aws_ami. In this example, aws_ami is a data source provided by the AWS provider for Terraform, which allows you to fetch information about AMIs available in your AWS account.

- This specific expression assumes that you have defined a data source block named aws_ami in your Terraform configuration and configured it to retrieve information about Ubuntu AMIs. The .id part of the expression accesses the ID attribute of the AMI object retrieved by the data source. This ID can then be used elsewhere in your Terraform configuration, such as in resource definitions, to reference the specific AMI you want to use for provisioning instances.

9. The command __ is used to extract the output variables defined in the Terraform configuration.

- terraform output

10. You have recently added new resource blocks from a different provider to your configuration. Type in the command you need to run before you can run a terraform plan/apply? __ 

- terraform init

11. You have the following code snippet as part of your Terraform configuration. How would you reference the id of the s3_bucket?
<pre>
data "aws_s3_bucket" "data_bucket" {
  bucket = "my-data-lookup-bucket-bk"
}
</pre>
- data.aws_s3_bucket.data_bucket.id

12. How can you reference all of the subnets created by this resource block?
<pre>
#Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]
 
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}
</pre>
- aws_subnet.private_subnets[*]

13. You want Terraform to redeploy a specific resource that it is managing. Type the command you should use to mark the resource for replacement. __

- terraform apply -replace

14. To force the destruction of resources without being prompted for confirmation, you can use the command __

- terraform destroy -auto-approve

15. To specify a specific Terraform workspace named "production" when running commands, you can use the command __

- terraform workspace select production

16. To list all resources in the current state, you can use the command __

- terraform state list

- The terraform state list command is used in Terraform, an infrastructure as code tool, to list all the resources currently being managed by Terraform within a particular state file. This command provides a quick overview of the resources that Terraform is aware of and managing. It's particularly useful for understanding what infrastructure resources have been provisioned and are being tracked by Terraform for any given project or environment.


17. The __ or the __ commands are available to delete all of your managed infrastructure.

    1. terraform destroy 
    2. terraform apply -destroy

18. You are using Terraform Cloud to store your state file. Before you can use Terraform Cloud, you should run the command __ to obtain and save credentials for the remote backend.

- terraform login

19. The __ command can be used to get an interactive console to evaluate expressions in your Terraform code.

- terraform console

20. What command can you use to display details about the resource as shown below?
<pre>
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "demo_igw"
  }
}
</pre>
- terraform state show aws_internet_gateway.demo

- terraform state show ADDRESS will show the attributes of a single resource, therefore the answer is aws_internet_gateway.demo













00. How can you reference all of the subnets created by this resource block?
<pre>
#Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]
 
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}
</pre>

Answer is incorrect
- aws_subnet.private_subnet.id

00. What command can you use to display details about the resource as shown below?
<pre>
 resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "demo_igw"
  }
}
</pre>

Correct answer
- terraform state show aws_internet_gateway.demo

Explanation
- terraform state show ADDRESS will show the attributes of a single resource, therefore the answer is aws_internet_gateway.demo

00. You need to access the attributes of a data source in your Terraform configuration for the following code. How should you reference the ID of the returned data? __ 
<pre>
data "aws_ami" "ubuntu" {
  most_recent = true
 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
 
  owners = ["099720109477"] 
}
</pre>
Correct answer
- data.aws_ami.ubuntu.id

00. You want Terraform to redeploy a specific resource that it is managing. Type the command you should use to mark the resource for replacement. __
<pre>
- terraform apply -replace
</pre>

- You would mark the resource for replacement using terraform apply -replace.
- NOTE: This used to be terraform taint and has been replaced with terraform apply -replace

00. The command __ is used to extract the output variables defined in the Terraform configuration.
<pre>
terraform output
</pre>

00. What command can be used to perform a dry-run of your changes and save the proposed changes to a file named bryan for future use? __
<pre>
terraform plan -out=bryan
</pre>

19. You have recently added new resource blocks from a different provider to your configuration. Type in the command you need to run before you can run a terraform plan/apply? __
<pre>
terraform init
</pre>

20. How would you call this code snipped.
<pre>
data "aws_s3_bucket" "data_bucket" {
  bucket = "my-data-lookup-bucket-bk"
}

Answer 
data.aws_s3_bucket.data_bucket.id (data.<resource type>.<resource name>.id)
</pre>

21. Freddy and his co-worker Jason are deploying resources in GCP using Terraform for their team. After resources have been deployed, they must destroy the cloud-based resources to save on costs. However, two other team members, Michael and Chucky, are using a Cloud SQL instance for testing and request to keep it running.  How can Freddy and Jason destroy all other resources without negatively impacting the database?
<pre>
run a terraform state rm command to remove the Cloud SQL instance from Terraform management before running the terraform destroy command
</pre>

22. What environment variable can be set to enable detailed logging for Terraform?
<pre>
TF_DEBUG
</pre>

Explanation
- The environment variable `TF_DEBUG` is not used to enable detailed logging for Terraform. It is typically used for debugging purposes and not for detailed logging.

23. From the code below, identify the implicit dependency:
<pre>
resource "aws_eip" "public_ip" {
    vpc      = true
    instance = aws_instance.web_server.id
}
 
resource "aws_instance" "web_server" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  depends_on    = [aws_s3_bucket.company_data]
}
</pre>
ANSWER 
- The EC2 instance labeled web_server

24. You are developing a new Terraform module to demonstrate features of the most popular HashiCorp products. You need to spin up an AWS instance for each tool, so you create the resource block as shown below using the for_each meta-argument. -------- After the deployment, you view the state using the terraform state list command. What resource address would be displayed for the instance related to vault?
<pre>
resource "aws_instance" "bryan-demo" {
  # ...
  for_each = {
    "terraform": "infrastructure",
    "vault":     "security",
    "consul":    "connectivity",
    "nomad":     "scheduler",
  }
}
</pre>
ANSWER 
- aws_instance.bryan-demo["vault"]

25. After many years of using Terraform Community (Free), you decide to migrate to Terraform Cloud. After the initial configuration, you create a workspace and migrate your existing state and configuration. What Terraform version would the new workspace be configured to use after the migration?
<pre>
the same Terraform version that was used to perform the migration
</pre>
Explanation
- The new workspace in Terraform Cloud will be configured to use the same Terraform version that was used to perform the migration. This ensures compatibility and consistency with the existing state and configuration.


26. Which of the following is a valid variable name in Terraform?
<pre>
version
lifecycle
count
invalid (INCORRECT)
</pre>
The word "invalid" is a valid variable name in Terraform as it follows the naming conventions for variables, which allow alphanumeric characters and underscores, and must start with a letter or underscore.

27. Where does Teraform Community (Free) store the local state for workspaces?
<pre>
directory called terraform.tfstate.d/<workspace name>
</pre>

Explanation
- Terraform Community (Free) stores the local state for workspaces in a directory called `terraform.tfstate.d/`. This directory structure allows for separate state files for each workspace, making it easier to manage and maintain the state data.
workspaces workspaces workspaces workspaces workspaces workspaces 

28. Which are some of the benefits of using Infrastructure as Code in an organization? (select three)
- OK IaC code can be used to manage infrastructure on multiple cloud platforms
- OK IaC allows you to commit your configurations to version control to safely collaborate on infrastructure
- OK IaC uses a human-readable configuration language to help you write infrastructure code quickly
- XXXXX IaC is written as an imperative approach, where specific commands need to be executed in the correct order XXXXXX


29. You are performing a code review of a colleague's Terraform code and see the following code. Where is this module stored?
<pre>
module "vault-aws-tgw" {
  source  = "terraform-vault-aws-tgw/hcp"
  version = "1.0.0"
  
  client_id      = "4djlsn29sdnjk2btk"
  hvn_id         = "a4c9357ead4de"
  route_table_id = "rtb-a221958bc5892eade331"
}
ANSWER the Terraform public registry

Explanation
The code specifies a source from "terraform-vault-aws-tgw/hcp", which is a typical format for modules stored in the Terraform public registry. This choice is correct based on the information provided in the code snippet.
</pre>


30. What do the declarations, such as name, cidr, and azs, in the following Terraform code represent and what purpose do they serve?
<pre>
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"
 
  name = var.vpc_name
  cidr = var.vpc_cidr
 
  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
 
  enable_nat_gateway = var.vpc_enable_nat_gateway
 
  tags = var.vpc_tags
}

ANSWER these are variables that are passed into the child module likely used for resource creation

Explanation
The values of the variables like name, cidr, and azs are not obtained from values created within the child module. Instead, these variables are typically defined and assigned values in the calling module or through input variables provided during the Terraform execution.
</pre>


31. When you add a new module to a configuration, Terraform must download it before it can be used. What two commands can be used to download and update modules? (select two)
<pre>
terraform get
The terraform get command is used to download modules from the module registry or a version control system, making them available for use in the configuration.

terraform init 
The terraform init command is used to initialize a working directory containing Terraform configuration files. It downloads any modules specified in the configuration.
</pre>

32. Code snippet would allow you to retrieve information about existing resources and use that information within your Terraform configuration?
<pre>
data "aws_ami" "aws_instance" {
  most_recent = true
 
  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}

Explanation
This code snippet defines a data block for retrieving information about an AWS AMI (Amazon Machine Image) based on specific criteria like owners and tags. This data can then be used within the Terraform configuration to make decisions or set attributes based on the retrieved information.
</pre>

33. When writing Terraform code, how many spaces between each nesting level does HashiCorp recommend that you use?
<pre>
2
</pre>
- 2 - spaces


