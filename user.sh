source common.sh

print_head "configure nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${log_file}
status_check $?

print_head "install nodejs "
yum install nodejs -y &>>${log_file}
status_check $?

print_head "adding user "
id roboshop &>>${log_file}
if [ $? -ne 0  ]
  then
  echo useradd roboshop &>>${log_file}
  fi
 status_check $?

print_head  "creating application directory"
if [ ! -d /app ]
 then
   echo mkdir /app  &>>${log_file}
   fi
status_check $?


print_head  "delete old content"
rm -rf /app/*  &>>${log_file}
status_check $?

print_head  "download the app content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>${log_file}
status_check $?
cd  /app

print_head  "extracting the content"
unzip /tmp/user.zip   &>>${log_file}
status_check $?

cd  /app
print_head  "installing the nodejs dependencies"
npm install &>>${log_file}
status_check $?

print_head  "copying service file"
 cp  ${code_dir}/configs/user.service    /etc/systemd/system/user.service  &>>${log_file}
status_check $?

print_head  "reloading user service "
systemctl daemon-reload  &>>${log_file}
status_check $?

print_head  "enabling user service"
systemctl enable user &>>${log_file}
status_check $?

print_head  "starting user service"
systemctl start user  &>>${log_file}
status_check $?

##To have it installed we can setup MongoDB repo and install mongodb-client
print_head  "copying mongodb "
cp ${code_dir}/configs/mongodb.repo  /etc/yum.repos.d/mongo.repo  &>>${log_file}
status_check $?

print_head  "installing mongodb schema "
yum install mongodb-org-shell -y   &>>${log_file}
status_check $?

print_head  "load schema"
mongo --host mongodb.devops164.online </app/schema/user.js  &>>${log_file}
status_check $?