source common.sh

print_head " setup the repo file"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo   &>>${log_file}
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
sed  -i -e  's/127.0.0.1/0.0.0.0/'  /etc/mongod.conf   &>>${log_file}
status_check $?


print_head " restart momgodb server"
systemctl restart mongod
status_check $?

