variable "resourcegroup" {
    type = string
    default = "rg11"

}

variable "location" {
    type = string


}


variable "storageaccount" {
    type = string


}

variable "accountt" {
    type = string
    #default = ""

}



variable "accountreplicationtype" {
    type = string
    #default = "GRS"

}

variable "env" {
    type = string
    default = "prod"

}
variable "cidrs" {
    type = list
    default = [ "10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24" ]

}