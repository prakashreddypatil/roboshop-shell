
print_head "installing redis repo files"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>>${log_file}
ststus_check $?

print_head "enabling redis 6.2 module "
dnf module enable redis:remi-6.2 -y   &>>${log_file}
ststus_check $?

print_head "install redis repo"
yum install redis -y  &>>${log_file}
ststus_check $?

print_head "Updating listen address /etc/redis/redis.conf"
##Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf & /etc/redis/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/'  /etc/redis/redis.conf  /etc/redis/redis.conf   &>>${log_file}
ststus_check $?

print_head "enabling redis service "
systemctl enable redis &>>${log_file}
ststus_check $?

print_head "starting redis service "
systemctl start redis  &>>${log_file}
ststus_check $?