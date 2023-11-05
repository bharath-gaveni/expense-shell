log_file="/tmp/expense.log"
clour="\e[36m"
echo -e "${clour} installing nginx \e[0m"
dnf install nginx -y &>>$log_file
if ( $? -eq 0 ); then
  echo -e "\e[32m Success \e[0m"
else
    echo -e "e[31m Failure \e[0m"
fi
echo -e "${clour} enabling nginx \e[0m"
systemctl enable nginx &>>$log_file
echo $?
echo -e "${clour} starting nginx \e[0m"
systemctl start nginx &>>$log_file
echo $?
echo -e "${clour} coping expense.conf file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?
echo -e "${clour} removing content in nginx file \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?
echo -e "${clour} dowloading frontend application content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?
echo -e "${clour} changing location \e[0m"
cd /usr/share/nginx/html &>>$log_file
echo $?
echo -e "${clour} unzipping the content in app directory \e[0m"
unzip /tmp/frontend.zip &>>$log_file
echo $?
echo -e "${clour} restarting the nginx  \e[0m"
systemctl restart nginx &>>$log_file
echo $?