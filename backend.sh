
log_file="/tmp/expense.log"
clour="\e[36m"
echo -e "${clour} disable nodejs \e[0m"
dnf module disable nodejs -y &>>log_file
echo $?
echo -e "${clour} enabling nodejs 18 version \e[0m"
dnf module enable nodejs:18 -y &>>log_file
echo $?
echo -e "${clour} installing nodejs18 \e[0m"
dnf install nodejs -y &>>log_file
echo $?
echo -e "${clour} installing mysql client \e[0m"
dnf install mysql -y &>>log_file
echo $?
echo -e "${clour} adding user \e[0m"
useradd expense &>>log_file
echo $?
echo -e "${clour} copying backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file
echo $?
echo -e "${clour} making a directory for application content to store \e[0m"
mkdir /app &>>log_file
echo $?
echo -e "${clour}downloading abackend application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
echo $?
echo -e "${clour} changing the directory \e[0m"
cd /app &>>log_file
echo $?
echo -e "${clour} unzipping the application content file  \e[0m"
unzip /tmp/backend.zip &>>log_file
echo $?
echo -e "${clour} changing the directory\e[0m"
cd /app &>>log_file
echo $?
echo -e "${clour} dowloading dependencies for nodejs software \e[0m"
npm install &>>log_file
echo $?
echo -e "${clour} reloading and starting the nodejs  \e[0m"
systemctl daemon-reload &>>log_file
echo $?
systemctl enable backend &>>log_file
echo $?
systemctl start backend &>>log_file
echo $?
echo -e "${clour} loading schema to mysql client \e[0m"
mysql -h mysql-dev.bharathgaveni.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
echo $?