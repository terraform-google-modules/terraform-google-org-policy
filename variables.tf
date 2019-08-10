variable "folder" {
  description = "The folder id for putting the policy"
  type        = string
  default     = ""
}

variable "org_id" {
  description = "The organization id for putting the policy"
  type        = string
  default     = ""
}

variable "policy_constraints" {
  description = "Map of maps defining constraints to apply"
}

variable "project" {
  description = "The project id for putting the policy"
  type        = string
  default     = ""
}

