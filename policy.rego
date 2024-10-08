package terraform
 
# Deny rule for instances not of type t2.micro
deny[instance] {
    instance := data.aws_instance.instances[_]  # Adjust this line to iterate over all instances
    instance.instance_type != "t2.micro"
}
 
# Deny rule for security group ingress rules
deny[sg] {
    sg := data.aws_security_group.web_sg
    allowed_ports = [22, 8080]
    not port_in_allowed_ports(sg.ingress[_].from_port)
}
 
# Helper function to check if port is allowed
port_in_allowed_ports(port) {
    allowed_ports = [22, 8080]
    port in allowed_ports
}
