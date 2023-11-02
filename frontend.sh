
echo -e "\e[31m installing nginx \e[0m"
dnf install nginx -y



systemctl enable nginx
systemctl start nginx
echo -e "\e[31m coping expense.conf file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf
echo -e "\e[31m removing content in nginx file \e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[31m dowloading frontend application content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip


cd /usr/share/nginx/html
echo -e "\e[31m unzipping the content in temporary file \e[0m"
unzip /tmp/frontend.zip
echo -e "\e[31m restarting the nginx  \e[0m"
systemctl restart nginx