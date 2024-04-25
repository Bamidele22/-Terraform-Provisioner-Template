#!/bin/bash
yum install wget unzip httpd -y
systemctl start httpd
systemctl enable httpd
wget https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip
unzip -o 2136_kool_form_pack.zip
cp -r 2136_kool_form_pack/*  var/www/html/
systemctl restart httpd

