# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)




# How To Use SFDX-CLI with GitHub Actions

## Create JWT Auth Flow
### Create Self-Signed Cert and Key

```bash
mkdir -p ~/.ssh/jwt
cd ~/.ssh/jwt
openssl genrsa -des3 -passout pass:SomePassword -out server.pass.key 2048
openssl rsa -passin pass:SomePassword -in server.pass.key -out server.key
rm server.pass.key
openssl req -new -key server.key -out server.csr
```

Enter your company information into the CSR Request prompts

```bash
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
```

If you are using VS Code remote, transfer the server.crt file to your workstation by opening it and saving it locally.

### Create Salesforce Connected App

1. App Manager -> New Connected App
1. Enter Callback URL: <http://localhost:1717/OauthRedirect>
1. Select Use digital signatures
1. Choose File and upload the server.crt
1. Add the following OAuth scopes:
    1. Manage user data via APIs (api)
    1. Manage user data via Web browsers (web)
    1. Perform requests at any time (refresh_token, offline_access)
1. Click Save
1. Click Manage
1. Click Edit Policies
1. In the OAuth Policies section, select Admin approved users are pre-authorized for permitted users
1. Click Save
1. Click Manage Profiles and then click Manage Permission Sets. Select the profiles and permission sets that are pre-authorized to use this connected app.

### Test

```bash
sfdx force:auth:jwt:grant --clientid=[85 char string] --jwtkeyfile=/home/username/.ssh/jwt/server.key --username=username@domain.com --setdefaultdevhubusername --setalias devjwt
```

## Add Actions to existing repo

### Setup Repository Actions Secrets

Create the following secrets:

* SALESFORCE_CONSUMER_KEY
* SALESFORCE_DEVHUB_USERNAME
* SALESFORCE_JWT_SECRET_KEY

### Download Actions script

```bash
mkdir -p .github/workflows
cd .github/workflows
wget https://gist.githubusercontent.com/vkeenan/a804be413512c1347990dea71626e484/raw/ed6c7d868735d1c8ac112dec763eb4c1bab8455c/push-action-deploy.yml
```

## Activate with GIT PUSH

```bash
git add .
git commit -m 'CI Installed'
git push
```

## Visit GitHub to check results

<https://github.com/>
