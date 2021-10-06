terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.17"
    }
  }

  backend "remote" {
    organization = "sql-intelligence"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "snowflake" {
}

resource "snowflake_database" "demo_db_tf" {
  name    = "DEMO_DB_TF"
  comment = "Database for Snowflake Terraform demo"
}

resource "snowflake_schema" "demo_schema" {
  database = snowflake_database.demo_db_tf.name
  name     = "DEMO_SCHEMA"
  comment  = "Schema for Snowflake Terraform demo"
}

resource "snowflake_table" "table1" {
  database            = "DEMO_DB_TF"
  schema              = "demo_schema"
  name                = "table1"
  comment             = "A table."
  
  column {
    name     = "id"
    type     = "int"
    nullable = true    
    }
  }