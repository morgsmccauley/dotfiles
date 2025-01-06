{ pkgs, ... }:
let
  # TODO: Figure out how to git ignore this file while still having it accessible within nix
  secrets = import ./aws-secrets.nix;
in {
  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        output = "json";
      };
      "profile admin-staging" = {
        sso_session = "helius";
        sso_account_id = secrets.aws_staging_account_id;
        sso_role_name = secrets.aws_staging_admin_role;
        region = "us-east-2";
      };
      "profile poweruser-prod" = {
        sso_session = "helius";
        sso_account_id = secrets.aws_prod_account_id;
        sso_role_name = secrets.aws_prod_power_role;
        region = "us-east-2";
      };
      "profile readonly-prod" = {
        sso_session = "helius";
        sso_account_id = secrets.aws_prod_account_id;
        sso_role_name = secrets.aws_prod_read_role;
        region = "us-east-2";
      };
      "profile admin-dev" = {
        sso_session = "helius";
        sso_account_id = secrets.aws_dev_account_id;
        sso_role_name = secrets.aws_dev_admin_role;
        region = "us-east-2";
      };
      "profile poweruser-dev" = {
        sso_session = "helius";
        sso_account_id = secrets.aws_dev_account_id;
        sso_role_name = secrets.aws_dev_power_role;
        region = "us-east-2";
      };
      "profile readonly-dev" = {
        sso_session = "helius";
        sso_account_id = secrets.aws_dev_account_id;
        sso_role_name = secrets.aws_dev_read_role;
        region = "us-east-2";
      };
      "sso-session helius" = {
        sso_start_url = secrets.aws_sso_start_url;
        sso_region = "us-east-1";
        sso_registration_scopes = "sso:account:access";
      };
    };
  };
}
