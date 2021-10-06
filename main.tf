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

resource "snowflake_table" "table" {
  database            = snowflake_database.demo_db_tf.name
  schema              = "demo_schema"
  name                = "table"
  comment             = "A table."
  
  column {
    name     = "id"
    type     = "int"
    nullable = true
  }

  column {
    name     = "data"
    type     = "text"
    nullable = false
  }

  column {
    name = "DATE"
    type = "TIMESTAMP_NTZ(9)"
  }

  column {
    name    = "extra"
    type    = "VARIANT"
    comment = "extra data"
  }

  primary_key {
    name = "my_key"
    keys = ["data"]
  }
}