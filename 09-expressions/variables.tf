variable "numbers_list" {
  type = list(number)
}

variable "maps_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
}