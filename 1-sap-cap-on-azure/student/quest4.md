# Quest 4 - Deploy your application to Azure

In this quest, you will bring your application to the Azure cloud to make it available to your favorite users. You will get credentials to log in to Azure's management portal and deploy all components to ...
- ...host your application,
- ...host your database,
- ...securely store credentials in a vault,
- ...observe your application with monitoring dashboards.


## Explore the Azure Portal 

- Open the Rest Endpoint and find values `azure-username` and `azure-password`.

- Open a new browser tab, go to the [Azure Portal (https://portal.azure.com)](https://portal.azure.com) and log in using these credentials.

> [!IMPORTANT]
> If you are asked to provide further security information, please click "Ask later" to skip.

- Navigate to "Resource groups". There are different way to do that:
  - Click the hamburger icon in the upper left corner, select "Resource groups" from the menu.
  - In the search bar, type "Resource groups" and select it from the "Services" section.
  - Select the "Resoruce groups" button from the landing page.

> [!TIP]
> <details><summary>If this is the first time you hear the term 'resource group'...</summary>
>  
> ...you might want to know that a [resource group](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources) is a kind of container that will hold all resources that constitute your application -- such as the database, the virtual networking components and the Azure Function to host your application code.
> 
> </details>

- Locate the resource group having the name of your username.

  ![](assets/2024-01-12-07-55-03.png)

## Login from your development terminal

> [!TIP]
> You will be using two different CLI tools in this quest: 
> - The [Azure Command-Line Interface (CLI) (`az`)](https://learn.microsoft.com/en-us/cli/azure/) is a set of commands used to create and manage Azure resources.
> - The [Azure Developer CLI (`azd`)](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview) is a tool that helps you getting your application from local development environment to Azure.

- Go back to your VS Code in your codespace.

- Log in using Azure CLI; follow the instructions to go confirm your identity in the browser.

  ```
  az login --use-device-code
  ```

  Example output:

  ```
  $ az login --use-device-code
  To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code CWVM7T7L5 to authenticate.
  ```

  ![](assets/2024-01-17-10-24-53.png)

  ![](assets/2024-01-17-08-05-11.png)

- Do the same exercise for the Azure Developer CLI. 

  ```
  azd auth login --use-device-code
  ```

## Setup your environment configuration


- In the terminal, switch into the `azd-rg` directory of your workspace.

  ```
  cd $CODESPACE_VSCODE_FOLDER/azd-rg
  ```

- Create a new Azure Developer CLI [environment](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/faq#what-is-an-environment-name). The environment will contain all parameters that are required to deploy the application to Azure and connect to the OData service.

  ```
  azd env new [Put your user  name here]
  ```
  e.g.,

  ```
  azd env new mhp-1
  ```

- Specify following environment properties; get all values from the link provided by your coaches:
  ```
  azd env new [YOUR PARTICIPANT ID HERE, e.g. mhp-1] 
  azd env set AZURE_RESOURCE_GROUP [YOUR PARTICIPANT ID HERE, e.g. mhp-1]
  azd env set AZURE_SUBSCRIPTION_ID [YOUR AZURE SUBSCRIPTION ID HERE]
  azd env set AZURE_LOCATION "westeurope"

  azd env set ODATA_URL "..."
  azd env set ODATA_SAP_CLIENT "..."
  azd env set ODATA_USERNAME "..."
  azd env set ODATA_USERPWD "..."

  azd env set APP_USE_ENTRAID_AUTHENTICATION "false"
  ```

  :construction: We'd need to confirm resource quotas.

> [!TIP]
> <details><summary>If you want, confirm these values...</summary>
> ...have been written successfully by running
>
> ```
> azd env get-values
> ```
> Example output:
> ```
> $ azd env get-values
> AZURE_ENV_NAME="mhp-2"
> AZURE_LOCATION="westeurope"
> AZURE_RESOURCE_GROUP="mhp-2"
> ...
> ```
> 
> </details>

## Deploy the application

- Provision the Azure resources defined as [Infrastructure as Code (IaC)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/readyconsiderations/infrastructure-as-code) in the `.bicep` files in the `infra` directory.
  ```
  azd provision
  ```
  Example output:
  ```
  $ azd provision
  Provisioning Azure resources (azd provision)
  Provisioning Azure resources can take some time.
  
  
  Subscription: [SELECT YOUR TARGET SUBSCRIPTION HERE]
  Location: [SELECT YOUR TARGET REGION HERE]
  
    You can view detailed progress in the Azure Portal:
    https://portal.azure.com/#view/HubsExtension/DeploymentDetailsBlade...
  
    (✓) Done: App Service plan: plan-kt6nr4qdrsqss
    (✓) Done: Log Analytics workspace: log-kt6nr4qdrsqss
    (✓) Done: Key Vault: kv-kt6nr4qdrsqss
    (✓) Done: Application Insights: appi-kt6nr4qdrsqss
    (✓) Done: Portal dashboard: dash-kt6nr4qdrsqss
    (✓) Done: App Service: app-api-kt6nr4qdrsqss
  Retrieving CosmosDB for PSQL (citus) FQDN...
  Storing CosmosDB for PSQL (citus) FQDN as POSTGRES_HOSTNAME in azure app settings...
  App settings have been redacted. Use `az webapp/logicapp/functionapp config appsettings list` to view.
  [...]
  
  SUCCESS: Your application was provisioned in Azure in 3 minutes 44 seconds.
  You can view the resources created under the resource group mhp-1 in Azure Portal:
  https://portal.azure.com/#@/resource/subscriptions/...
  ```
- Deploy the application packaged in the first step to the resources deployed in Azure.
  ```
  azd deploy
  ```
  Example output:
  ```
  $ azd deploy
  Deploying services (azd deploy)
  
    (✓) Done: Deploying service sap-cap-api
    - Endpoint: https://app-api-kt6nr4qdrsqss.azurewebsites.net/
  
  
  SUCCESS: Your application was deployed to Azure in 7 minutes 43 seconds.
  You can view the resources created under the resource group mhp-1 in Azure Portal:
  https://portal.azure.com/#@/resource/subscriptions/...
  ```
  
> [!TIP]
> <details><summary>If you want to speed up your deployment even more...</summary>
>  
> ...you might want to know that the `azd up` command combines the steps `azd provision` and `azd deploy` in one and allows for a "one shot" deployment:
> ```
> azd up
> ```
> 
> Example output:
> ```
> [...]
> 
> Deploying services (azd deploy)
> 
> (✓) Done: Deploying service sap-cap-api
> - Endpoint: https://app-api-mtdcoapdqo6wm.azurewebsites.net/
> 
> SUCCESS: Your application was provisioned and deployed to Azure in 1 minute 39 seconds.
> ```
> 
> </details>


## Inspect the deployment in Azure

- Go back to the [Azure portal (https://portal.azure.com)](https://portal.azure.com) and browse to your resource group.

- Confirm a set of resources have been deployed to host your application.

  ![](assets/2024-01-15-07-54-48.png)

- The resource of type "App Service" is hosting your application. Open that one up and locate the URL endpoint for this application.

  ![](assets/2024-01-15-08-13-16.png)

- Open the application by clicking the link behing "Default domain" and do a first smoke test of your application.

  ![](assets/2024-01-15-08-14-17.png)

- Click the link to `index.html` below "Web Applications" to retrieve some data from the OData service.

  ![](assets/2024-01-17-19-07-04.png)

## Inspect the application log

As managed service, the "App Service" resource hosting your application comes with a lot of platform-managed capabilities. For example, you can easily inspect the log information written from your console. 

- Typically, there are different paths to achieve the same goal. One way to view the application log is to open the Azure Portal, browse to App Service resource and open up the "Logstream" blade in the "Monitoring" section:

  ![](assets/2024-01-17-18-21-02.png)

- For automation or if you feel more comfortable using the command-line interface (CLI), you can equally invoke the command 

  ```
  az webapp log tail --resource-group [YOUR RESOURCE GROUP NAME HERE] --name [YOUR APP SERVICE NAME HERE]
  ```


## Claim your badge now! 🎖️

Congratulations! You have successfully completed this tutorial and can show your friends that you have now successfully deployed you SAP CAP application to Azure App Services. To claim your badge, you need a URL and an access code from your coaches. Therefore, please send short mail to the address shared in your session and share the link to your application with them.

```
To:       [Coaches' mail address.]
Subject:  I'm done!

Body:
[Paste your application URL here.]
```

## Further exploration

> [!IMPORTANT]
> The following sections are optional. Please select where you want to go deeper depending on your progress, remaining time and your personal interest and feel free to continue with quest 5 if you prefer.

### (optional) Inspect pre-defined dashboards

As part of the infrastructure provisioning step, any `azd` project will come with monitoring tooling built-in. The tooling is built on different services from the [Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/overview) family:

- [Application Insights](https://learn.microsoft.com/azure/azure-monitor/app/app-insights-overview?tabs=net)
- [Application Insights Dashboards](https://learn.microsoft.com/azure/azure-monitor/app/overview-dashboard)
- [Log Analytics](https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-overview)

The setup comes with three basic dashboards that you can access via the portal or via `azd` commands:

  - Main dashboard: 
    ```
    azd monitor --overview
    ```

  - Live metrics dashboard:
    ```
    azd monitor --live
    ```

    :construction: Shows me 'No Data'.

  - Log datasink:
    ```
    azd monitor --logs
    ```

This gives you a solid starting point for monitoring your application as well as troubleshooting it.

### (optional) Connect to cloud-hosted PostgreSQL database

To store application data, an instance of [Azure Cosmos DB for PostgreSQL documentation](https://learn.microsoft.com/en-us/azure/cosmos-db/postgresql/) was deployed in the Azure cloud. As this application exposes the APIs of a common PostgreSQL database, you can use any existing application or administration tool that supports PostgreSQL databases to connect to the database. 

- Open the Adminer interface again as you did in [quest 3](quest3.md).

- In the [Azure Portal (https://portal.azure.com)](https://portal.azure.com), browse to the resource of type "Azure Cosmos DB for PostgreSQL Cluster" in your resource group; this resource represents your database cluster. Copy the FQDN specified as "Coordinator name" to your clipboard and paste in the "host" field of your Adminer login page.

  ![](assets/2024-01-17-19-01-15.png)

- The secret password for the admin username has been stored in the Key Vault resource in your resource group.  Browse to your vault, open the "Secrets" blade and select item `kv-secret-cosmosdb-password`. 

  ![](assets/2024-01-17-19-04-02.png)

  Klick the id of the "Current Version" and copy the secret value to your clipoard.

  ![](assets/2024-01-17-19-04-14.png)

  ![](assets/2024-01-17-19-04-36.png)

- Login to your cloud-hosted database using Adminer

  ![](assets/2024-01-17-19-05-38.png)

  ...and select table `businesspartnerlocal` and click select to verify data from OData service got loaded into the database:

  ![](assets/2024-01-17-19-08-31.png)

> [!TIP]
> If the table is empty, you might not yet have triggerd data population from the OData service by launching your application from the startup landing page.


### (optional) Explore application security 

To ensure security an application you deploy to Azure, one crucial point is to protect access credentials for backend components. Azure therefore offers two major capabilities:
- Use [Azure Key Vault](https://learn.microsoft.com/azure/key-vault/general/overview) as central storage for all Keys, Secrets and Certificates for applications hosted on the Azure cloud.
- Completely avoid access credentials by using [managed identities](https://learn.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview) and rely on the Azure platform to handle authentication of backend services for you.

#### Explore the Key Vault

- Open your Key Vault resource. 

- In the "Objects" section, select the "Secrets" blade. It will list four secrets (like passwords or API keys) stored in the vault.

  ![](assets/2024-01-23-08-04-29.png)

- For example, klick "kv-secred-odata-password", and the opening page, click the latest secret version.

  ![](assets/2024-01-23-08-08-01.png)

- This will show you some meta data and, at the bottom of the page, a button to show the secret value:

  ![](assets/2024-01-23-08-08-57.png)

#### Explore the App Service's Managed Identity

- Open your App Service resource and browse to the "Identity" blade in the "Settings" seciton. Verify the state is "On".

  ![](assets/2024-01-23-07-32-23.png)

  This will allow your application (including your custom-code) to rely on platform capabilities to access other Azure resources. 

- Open the "Configuration" blade; the "Application Settings" lists all parameters that will be supplied to your application as environment variables. To explore the values, click the "Show values" button.

  ![](assets/2024-01-23-07-37-39.png)

- Explore the settings that contain secret values (e.g., `ODATA_USERPWD`); instead of specifying the value explicity, it refers to your Azure Key Vault. 

  ```
  @Microsoft.KeyVault(SecretUri=https://kv-kt6nr4qdrsqss.vault.azure.net/secrets/kv-secret-odata-password)
  ```

> [!TIP]
> Note that this refernece does not contain a password to authenticate access from the App Service -- it only holds a resource to the specific secret.

- Go to the Key Vault and open the "Access policies" blade. You see that the Key Vault uses the App Service's managed identity to authorize access.

  ![](assets/2024-01-23-07-42-18.png)



### (optional) Debug the application on Azure

Once in a while, you may need to connect to your application running on Azure to debug your source code. VS Code allows you to remotely debug a Node.js application running on Azure directly from your IDE as described [here](https://code.visualstudio.com/docs/azure/remote-debugging). This capability comes with the [Azure App Service extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice) that  also allows you to perform administrative tasks like restarting from your IDE.

To set up remote debugging for this CAP project, follow [this step-by-step guide](http://...) in the project repository.
:construction: Add link to repo once guide is there.

> [!TIP]
> If you use other Azure platform services in your own project, you may want to browse the marketplace for Visual Studio Code. There are a lot of extensions avaialble which are maintained and published by Microsoft and the community. Just select Categoriy `Azure` in search field or click [here](https://marketplace.visualstudio.com/search?target=VSCode&category=Azure&sortBy=Publisher).

## Where to next?

[ < Quest 3 ](quest3.md) - **[🏠Home](../README.md)** - [ Quest 5 >](quest5.md)

[🔝](#)



