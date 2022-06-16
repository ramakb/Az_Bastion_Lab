### Objectives of Azure Bastion Lab

1. Create Resource Group

2. Create VNet, Subnet in the RG

3. Create Azure Bastion Host, Subnet for it and also assign a Public IP to the AZBHost

4. Creat Azure Key Vault and create a Secret for accessing the LinuxVM

5. Deploy Linux VM and use that secret as admin_password

6. Define NSG Security Rules for AZBHost and also Define for LinuxVM and associate to the respective
   Subnet and NIC as per the needs

7. `terraform apply --auto-approve` shows the below resources
   ![Azure Portal](/images/Terraform_Apply.png)

8. Test the connection
   - From the Portal, connec to Linux VM through 'AzureBastion' and it will open a browser --> after entering the username and secret password, login successfully
   ![Ping to LinuxVM](/images/LinuxVM_Login.png)

Once this is done, use `terraform destroy --auto-approve` to free up the Resources from the portal when you are ready