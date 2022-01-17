# for more information on this configuration, run `envconsul -h` or see https://github.com/hashicorp/envconsul#configuration-file
consul {
  # Sets the address of the Consul instance
  # This value should be retrieved from environment variables directly or by loading `.envrc`.
  #address = "..."

  # Sets the Consul API token
  # This value should be retrieved from environment variables directly or by loading `.envrc`.
  #token = "..."

  retry {
    # Use retry logic when communication with Consul fails
    enabled = true

    # The number of attempts to use when retrying failed communications
    attempts = 3

    # The base amount to use for the backoff duration.
    backoff = "500ms"

    # The maximum limit of the retry backoff duration.
    max_backoff = "1m"
  }

  ssl {
    # Use SSL when connecting to Consul
    enabled = true

    # Verify certificates when connecting via SSL
    verify = true
  }
}

vault {
  # Sets the address of the Vault server
  # This value should be retrieved from environment variables directly or by loading `.envrc`.
  # address = "..."

  # Sets the Vault namespace
  # This value should be retrieved from environment variables directly or by loading `.envrc`.
  # namespace = "..."

  # Sets the Vault API token
  # This value should be retrieved from environment variables directly or by loading `.envrc`.
  # token = "..."

  # File to read Vault API token from.
  # This value should be retrieved from environment variables directly or by loading `.envrc`.
  # vault_agent_token_file = "..."

  # Unwrap the provided Vault API token
  unwrap_token = false

  # Periodically renew the provided Vault API token
  renew_token = false

  retry {
    # Use retry logic when communication with Consul fails
    enabled = true

    # The number of attempts to use when retrying failed communications
    attempts = 3

    # The base amount to use for the backoff duration.
    backoff = "500ms"

    # The maximum limit of the retry backoff duration.
    max_backoff = "1m"
  }

  ssl {
    # Use SSL when connecting to Consul
    enabled = true

    # Verify certificates when connecting via SSL
    verify = true
  }
}
