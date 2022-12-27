
# Query for ALL active availability zones
data "aws_availability_zones" "available" {
  state = "available"
}