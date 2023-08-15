locals {
    base_resource_name = "${var.resource_name_prefix}-${var.workload_name}-${var.environment_name}"
    base_name_lower_no_dashes = "${lower(replace(local.base_resource_name, "-", ""))}"
    base_name_short = length(local.base_name_lower_no_dashes) > 22 ? substr(local.base_name_lower_no_dashes, 0, 22) : local.base_name_lower_no_dashes
    log_analytics_workspace_name = "${local.base_resource_name}-laws"
    application_insights_name = "${local.base_resource_name}-ai"
    key_vault_name = "${local.base_resource_name}-kv"
    managed_identity_name = "${local.base_resource_name}-uami"
    logic_app_name = "${local.base_resource_name}-la"
    storage_account_name = "${local.base_name_short}sa"
}