variable "database_instance_type" {
  type        = string
  description = "instance size of the database"
}
variable "database_engine_type" {
  type        = string
  description = "RDS engine type of the database"
}
variable "database_engine_version" {
  type        = string
  description = "RDS engine version of the database"
}
variable "database_multi_az" {
  type        = bool
  description = "deploys the database into multiple availability zones"
  default     = true
}
variable "database_storage_size" {
  type        = number
  description = "size in GB of the database"
  default     = 20
}
variable "database_skip_final_snapshot" {
  type        = bool
  description = "do not create a final database snapshot before deleting the database"
  default     = false
}
variable "database_backup_retention_period" {
  type        = string
  description = "number of days to retain backups for the database"
  default     = 30
}
variable "database_backup_window" {
  type        = string
  description = "the daily time range (in UTC) for automated backups which are created for the database"
}
variable "database_maintenance_window" {
  type        = string
  description = "the daily time range (in UTC) during which the database will be maintained by Amazon RDS service"
}
