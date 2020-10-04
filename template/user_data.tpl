 #!bin/bash
   yum install httpd -y
   systemctl restart httpd
   chkconfig httpd on
   echo "deployed by Terraform" > /var/www/hmtl/index.html

