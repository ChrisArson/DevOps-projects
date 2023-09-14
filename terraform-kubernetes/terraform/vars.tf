variable REGION {
	default = "us-east-1"
}
variable ZONE1 {
	default = "us-east-1a"
}
variable AMI {
	type = map
	default = {
		us-east-1 = "ami-0261755bbcb8c4a84"
	}
}
variable USER {
	default = "ubuntu"
}
