##RG
variable "rgname01" {}
variable "rglocation01" {}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

#Keyvault
variable "kvt1" {}
variable "kvtrglocation01" {}
variable "kvtrgname01" {}
#variable "user1" {}
variable "user2" {}
#variable "user3" {}