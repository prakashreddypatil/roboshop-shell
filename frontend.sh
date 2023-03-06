source common.sh

print_head "installing nginx"
yum install nginx -y  &>>${log_file}
if [ $? -eq 0 ]
then
  echo sucess
  else
  echo FAILURE
  fi

print_head "removing old content"
rm -rf /usr/share/nginx/html/*  &>>${log_file}
if [ $? -eq 0 ]
then
  echo sucess
  else
  echo FAILURE
  fi

print_head  "downloading frontend"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${log_file}
if [ $? -eq 0 ]
then
  echo sucess
  else
  echo FAILURE
  fi

print_head "extracting  download frontend"
cd  /usr/share/nginx/html
unzip /tmp/frontend.zip  &>>${log_file}
if [ $? -eq 0 ]
then
  echo sucess
  else
  echo FAILURE
  fi

print_head "copying nginx config for roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
if [ $? -eq 0 ]
then
  echo sucess
  else
  echo FAILURE
  fi

print_head  "enabling nginx"
systemctl enable nginx  &>>${log_file}
if [ $? -eq 0 ]
then
  echo sucess
  else
  echo FAILURE
  fi

print_head "starting nginx"
systemctl start nginx  &>>${log_file}
if [ $? -eq 0 ]
then
  echo sucess
  else
  echo FAILURE
  fi

