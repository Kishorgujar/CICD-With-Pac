package terraform
 
# Deny rule for instances not of type t2.micro
deny[instance] {
    instance := data.aws_instance.instances[_]  # Adjust this line to iterate over all instances
    instance.instance_type != "t2.micro"
}
 
