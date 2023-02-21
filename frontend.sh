echo -e "\e[35mInstalling nginx\e[0m"
yum install nginx -y

echo -e "\e[removing old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35Downloding the frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[35extracting frontend\e[0m"

cd  /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[35copying nginx config  for Roboshop\e[0m"
cp configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\[35m enableing nginx\e[0m"
systemctl enable nginx

echo -e "\[35mstarting nginx\e[0m"
systemctl start nginx