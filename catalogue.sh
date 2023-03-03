code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}
print_head() {
  echo -e "\e[35m$1\e[0m"
}
print_head "configure nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>${log_file}

print_head "install nodjs"
yum install nodejs -y   &>>${log_file}

print_head "create roboshop user"
useradd roboshop  &>>${log_file}

print_head "create application directory"
mkdir /app  &>>${log_file}

print_head  "delete old content"
rm -rf /app/*  &>>${log_file}

print_head  "download the app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>>${log_file}

cd /app  &>>${log_file}

print_head  "extracting the content"
unzip /tmp/catalogue.zip  &>>${log_file}

cd /app  &>>${log_file}

print_head  "installing the nodejs dependencies"
npm install &>>${log_file}

print_head  "copy sysytemd service file"
cp ${code_dir}/configs/catalogue.service  /etc/systemd/system/catalogue.service &>>${log_file}

print_head  "reload systemd"
systemctl daemon-reload  &>>${log_file}

print_head  "enable catalogue server"
systemctl enable catalogue &>>${log_file}

print_head  "start catalogue server"
systemctl start catalogue &>>${log_file}

print_head  "copy mongodb repo file"
cp ${code_dir}/configs/mongodb.repo  /etc/yum.repos.d/mongodb.repo &>>${log_file}

print_head  "install mongodb schema"
yum install mongodb-org-shell -y &>>${log_file}

print_head  "load schema"
mongo --host mongodb.devops164.online </app/schema/catalogue.js  &>>${log_file}