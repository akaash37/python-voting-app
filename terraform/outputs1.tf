output "bastion_public_ip" { value = aws_instance.bastion.public_ip }
output "jenkins_private_ip" { value = aws_instance.jenkins.private_ip }
output "app_private_ip" { value = aws_instance.app.private_ip }
output "bastion_sg_id" { value = aws_security_group.bastion_sg.id }
output "private_sg_id" { value = aws_security_group.private_sg.id }
output "public_web_sg_id" { value = aws_security_group.public_web_sg.id }