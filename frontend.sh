code_dir=$(pwd)

echo -e "\e[35minstalling nginx\e[0m"
yum install nginx -y

echo -e "\e[35enabling nginx\e[0m"
systemctl enable nginx

echo -e "\e[35starting nginx\e[0m"
systemctl start nginx

echo -e "\e[35removing old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35downloading frontend\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[35extracting  download frontend\e[0m"
cd  /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[35copying nginx config for roboshop\e[0m"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35enabling nginx\e[0m"
systemctl enable nginx

echo -e "\e[35starting nginx\e[0m"
systemctl start nginx