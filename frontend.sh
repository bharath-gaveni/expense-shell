source common.sh
echo -e "${clour} installing nginx \e[0m"
dnf install nginx -y &>>$log_file
status_check
echo -e "${clour} coping expense.conf file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status_check
echo -e "${clour} removing content in nginx file \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check
echo -e "${clour} downloading frontend application content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
status_check
echo -e "${clour} changing location \e[0m"
cd /usr/share/nginx/html &>>$log_file
status_check
echo -e "${clour} unzipping the content in app directory \e[0m"
unzip /tmp/frontend.zip &>>$log_file
status_check
echo -e "${clour} restarting the nginx  \e[0m"
systemctl restart nginx &>>$log_file
systemctl enable nginx &>>$log_file
status_check