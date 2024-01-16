data = {
  parent_type     = "{{.parent_type}}"
  parent_id       = "{{.parent_id}}"
  billing_account = "{{.billing_account}}"
  state_bucket    = "{{.terraform_state_storage_bucket}}"
  # Default locations for resources. Can be overridden in individual templates.
  storage_location    = "{{.devops_storage_region}}"
  labels = {
    env = "prod"
  }
}

template "devops" {
  recipe_path = "git://github.com/GoogleCloudPlatform/healthcare-data-protection-suite//templates/tfengine/recipes/devops.hcl"
  output_path = "./devops"
  data = {
    # TODO(user): Uncomment and re-run the engine after generated devops module has been deployed.
    # Run `terraform init` in the devops module to backup its state to GCS.
    #enable_gcs_backend = true

    admins_group = {
      id = "{{.admin_group}}"
      exists = true
    }

    project = {
      project_id = "{{.devops_project_id}}"
      owners_group = {
        id = "{{.owners_group}}"
        exists = true
      }
    }
  }
}
