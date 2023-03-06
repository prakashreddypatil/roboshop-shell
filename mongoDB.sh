source common.sh

print_head " copying the repo file"
cp configs/mongodb.repo /etc/yum.repos.d/mongodb.repo   &>>${log_file}
status_check $?

print_head " installing mongodb"
yum install mongodb-org -y  &>>${log_file}
status_check $?

print_head " enabling mongodb"
systemctl enable mongod  &>>${log_file}
status_check $?

print_head " starting momgodb server"
systemctl start mongod  &>>${log_file}
status_check $?

print_head " updating listing address"
sed -i -e  's/127.0.0.1/0.0.0.0/'  /etc/mongodb.conf  &>>${log_file}
status_check $?
## Updated 127.0.0.1 to 0.0.0.0 in /etc/mongodb.conf

print_head " restarting the server "
systemctl restart mongod  &>>${log_file}
status_check $?