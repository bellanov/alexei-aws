# Alexei-AWS

This project holds the ***Terraform*** that manages the creation of **Alexei**, a DevOps management tool.

## Methodology / Design Patterns

Information about *design patterns* prevalent in the architecture.

### aws-vault

**aws-vault** is a CLI tool that is used to effectively manage AWS credentials. This will be used to properly assign and deliver permissions appropriately to *developers*, *testers*, etc.

#### Example

In the example below, the **Terraform** command is executed with the privileges granted to the ***development_1*** profile.

```sh
aws-vault exec development_1 -- terraform plan -out example.tfplan

```

### Semantic Versioning (X.Y.Z)

Products should aptly be versioned so changes are properly tracked as they traverse development *environments*.

Example Workflow:

1. A feature undergoes development in the *dev* "environment" and assigned a **version** (i.e., 0.1.0).
1. After iterating the feature in *dev*, and a candidate (i.e., 0.1.15) for release is ready, it is **promoted** to the *qa* environment for testing; Otherwise, it is **demoted** back to *dev* for further fixes.
1. Upon meeting testing and code coverage requirements, the feature is then promoted to *prod* (production) and is ready for consumption by customers.

## Workflow

Once changes have been tested, they can be applied.

```bash
cd ./environments/dev
terraform init
terraform plan
terraform apply
```

## Alexei Ecosystem

A summary of the *applications* and *services* deployed within the Alexei ecosystem.

![Alexei Ecosystem](/diagrams/Alexei.png)
