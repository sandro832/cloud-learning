# Run Terraform template

1. Authenticating using the Azure CLI:

    ```
    az login
    az account set --subscription="xxxx"
    ```

2. Running the terraform

    First run INIT:

    ```
    terraform init 
    ```

    Run to ensure modules are up-to-date:
    ```
    terraform get -update
    ```

    Run the PLAN:
    ```
    terraform plan -out .tfplan
    ```

    You then will run APPLY:
    ```
    terraform apply .tfplan
    ```
