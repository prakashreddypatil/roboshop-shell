code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

read_head() {
  echo -e "\e[35m$1\e[0m"
}

echo  "installing nginx"
yum install nginx -y &>>${log_file}

echo  "removing old content"
rm -rf /usr/share/nginx/html/*  &>>${log_file}

echo  "downloading frontend"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${log_file}

echo  "extracting  download frontend"
cd  /usr/share/nginx/html
unzip /tmp/frontend.zip  &>>${log_file}

echo "copying nginx config for roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

echo  "enabling nginx"
systemctl enable nginx  &>>${log_file}

echo -e "starting nginx"
systemctl start nginx  &>>${log_file}
