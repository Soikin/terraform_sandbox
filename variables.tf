variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public_key" {
  type = map(string)
  default = {
    name = "Ales.Soikin@itechart-group.com"
    key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkgPoyx4oq6m7TH4f8GiMD5LubYj16bIw3cp7Uh8xcWVnIqD6kS7vaKungd62NdsXdgT6yAG2GWkj0EIxFs2gQIEOO3LuPgnxMwxCOMWorhd72ZDqxElJaAgSywvH5EfzXgUUdbVgHQSqzxK+ieLiE/+fjdX2wdE8NCou1ISIzIHLEOcU0kJ+Ho7zVJQuTHl4XTZbwn1BvKFNGd4Qok1ulmBD9OgUnSoL+s9ioGhtADRr+emOMJ39L1Ay5i7b6aTQBw05RsnPZCpSukJKp4K8qSF3ZwCSNX/20oO1tM29B/xUuNculFMhjEMUlLTNoTZSCb4lvWDdURCcNYR0hXpqraXl7/xOy4GCpXTp3F0vpUZwXKI1uCSpXM1nfIL+86twlcmZvB3lcrG3MEjHz7gUnE26mm/ILindl09T2f+rsRBNFKm2MIFAM0Uxq+lMv9qTYuauY6+XUHl+odN1pG+XPtJNZOQOHaqRMuTLzARAZ2l2ug2tdFkrMLDtRLeh2DN1nVPyshtYauCvNRtKgzVILaWZSDbEbCYtauzpNUMr86JaClZlQiCFm+9XbzzZYVEpvmCtBKfXhUo/QM5CTBfczcOgZrrq3EmGffun0WWJ3q6ZXK3dDtMBmBfTIJVgQv4Tz+FM5DoQcKxTeD+oe2KHCvogJjTJ8KJCy6nrReXShQQ== Ales.Soikin@itechart-group.com"
  }
}
