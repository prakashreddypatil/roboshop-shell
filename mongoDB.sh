code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}
print_head() {
  echo -e "\e[35m$1\e[0m"
}

print_head " copying the repo file"
cp configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

print_head " installing mongodb"
yum install mongodb-org -y  &>>${log_file}

print_head " enabling mongodb"
systemctl enable mongod  &>>${log_file}

print_head " starting momgodb server"
systemctl start mongod  &>>${log_file}

print_head " updating listin address"
## Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongodb.conf

print_head " restarting the server "
systemctl restart mongod  &>>${log_file}