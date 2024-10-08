package terraform
 
# Define the rule that checks the instance type
deny[instance] {
    instance := data.aws_instance.web
    instance.instance_type != "t2.micro"
}
 
# Define the rule that checks the security group ingress rules
deny[sg] {
    sg := data.aws_security_group.web_sg
    # Check for allowed ingress ports
    allowed_ports = [22, 8080]
    not port_in_allowed_ports(sg.ingress[_].from_port)
}
 
# Helper function to check if port is allowed
port_in_allowed_ports(port) {
    allowed_ports = [22, 8080]
    port in allowed_ports
}
