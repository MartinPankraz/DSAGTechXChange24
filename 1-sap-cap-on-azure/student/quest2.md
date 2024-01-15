# Quest 2 - Prepare your development environment


## Prepare your fork.

- Log in to Github

- Browse to [MartinPankraz/DSAGTechXChange24: Content supporting the DSAG TechXChange Feb 2024](https://github.com/MartinPankraz/DSAGTechXChange24) 

- Fork the repository into your own GitHub account.
  
  ![](2024-01-10-14-43-51.png)

  ![](2024-01-10-14-49-41.png)

## Prepare your development environment

You have two options:
- Use  [GitHub Codespaces](https://github.com/features/codespaces): GitHub Codespaces allows you to use a development environment hosted by GitHub. You can access this development environment either via a browser or using the VSCode installation on your developer machine. (:construction: Better explanation / more pros and cons.)

- Clone the repository to your development machine. Please only select this path if you are confident to be all set on your dev machine. (:construction: What do they need to be 'all set'.?)

  :point_up: We will not explain this path in the remainder of this tutorial.

### Initialize your codespace

- Open your fork of the repository.

- Create a new Codespace on main:

  ![](2024-01-10-14-57-12.png)

- Wait a couple of seconds until deployment of your code space has terminated:

  ![](2024-01-10-14-57-59.png)

  Following the 'logs', you can see how GitHub prepares the your development environment by installing all prerequesites for your development cycle.


- Once your dev container is available, you'll see VScode with your repo opened in your browser: 

  ![](2024-01-10-15-01-13.png)

  :construction: Explain areas: browser, file editing area, terminal.

- (:bulb:) If you are interested to see how GitHub knows which components it has to deploy into your codespace, you may want to browse file `.devcontainer/devcontainer.json`. It lists CLI tools such as `azure-cli` (in the `features` section) as well as extensions for VSCode (in the section `customizations / vscode / extensions`).

- To confirm CLI tools are well set up, invoke following commands in terminal at the bottom of the VScode view:

  ```
  az version
  ```
  and
  ```
  azd version
  ```
  The output should look like that:
  ```
    @username ➜ /workspaces/app-service-javascript-sap-cap-quickstart (main) $ az version
    {
    "azure-cli": "2.56.0",
    "azure-cli-core": "2.56.0",
    "azure-cli-telemetry": "1.1.0",
    "extensions": {}
    }
    @username ➜ /workspaces/app-service-javascript-sap-cap-quickstart (main) $ azd version
    azd version 1.5.1 (commit 3856d1e98281683b8d112e222c0a7c7b3e148e96)
  ```

  ![](2024-01-10-15-10-03.png)

  :construction: Highlight that we won't screenshot Terminal output (but make it code blocks.) going forward.

#### (Optional) Use your local VSCode installation to connect to your codespace from your developer machine.

- Start the VSCode deployed on your developer machine.

- Make sure you have the extension "GitHub Codespaces" installed.

  ![](2024-01-10-15-31-25.png)

- Once installed, open the command palette by pressing `Ctrl + Alt + p`, type `Codespaces` and select `Connect to codespace`:
  
  ![](2024-01-10-15-32-35.png)

- Login to GitHub from VScode.

  ![](2024-01-10-15-33-27.png)

- Select the codespace you have just created.

  ![](2024-01-10-15-34-21.png)

- See how VScode refreshes and loads your repo content in your local VScode window.

- :bulb: Open a new Terminal and run `az version` and `azd version`.

  ![](2024-01-10-15-37-03.png)

  You might also want to run command `hostname` and `uname -a` to see that these commands effectively run on your Codespace (and not your developer machine):

  ![](2024-01-10-15-39-10.png)

  

## Where to next?

[ < Quest 1 ](quest1.md) - **[🏠Home](../README.md)** - [ Quest 3 >](quest3.md)

[🔝](#)
