# AKV-ExpiringSecrets

This is a small PS script that gets all secrets from [Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/) that are going to expire in a given amount of time. It authenticates via a SPN to Azure Key Vault to have it runnable in automation scenarios. 