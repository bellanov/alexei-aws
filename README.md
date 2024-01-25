# alexei-aws

Alexei *Amazon Web Services* port.

## Terraform

Initially, the Terraform will be completely comprised *within* the project **root**. It will be split up into multiple *environments* as **modules** are developed to deploy within those environments.

For instance, a prospective environment could be called **tf_deploy_bellanov** that deploys the infrastruture of the Bellanov L.L.C. **organization**.

## Semantic Versioning (X.Y.Z)

Projects should aptly be ***versioned*** so changes are properly tracked as they *traverse* development environments.

Example Workflow:

1. A feature undergoes development in the dev "environment" and assigned a **version** (i.e., 0.1.0).
1. After iterating the feature in dev, and a candidate (i.e., 0.1.15) for release is ready, it is **promoted** to the qa environment for testing; Otherwise, it is **demoted** back to dev for further fixes.
1. Upon meeting **testing** and **code coverage** requirements, the feature is then promoted to **prod** (production) and is ready for consumption by customers.

## SECRET Variable Shuffle

Overview on how to create a new **secret variable** and **integrate** it with Terraform Cloud.

1. Create the variable within the project and assign it a blank *default value*.
1. Create a corresponding variable in Terraform Cloud. For instance, using a *Workspace Variable* or creating a *Variable Set*.
1. Assign the variable to the project via the **Workspace** / **Variable Set** methods.
1. *Plan* & *Apply*!!!

## Importing Existing Resources

In certain circumstances, resources can be created within the console then imported into Terraform. This helps amateurs with Terraform in that they don't have to code their way to procuring resources.

To do so, establish the appropriate authentication context via `terraform login`, as credentials are saved remotely in Terraform Cloud. 

Existing resources can then be imported into new resource statements.

```sh
# Import existing bucket
terraform import aws_s3_bucket.bucket bucket-name

# Import existing VPC
terraform import aws_vpc.test_vpc vpc-a01106c2
```
