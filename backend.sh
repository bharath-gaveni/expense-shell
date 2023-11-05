
log_file="/tmp/expense.log"
clour="\e[36m"
if [ -z "$1" ]; then
  echo provide password
  exit
fi
MY_SQL_ROOT_PASSWORD="$1"
status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[31m FAILURE \e[0m"
  fi
}
echo -e "${clour} disable nodejs \e[0m"
dnf module disable nodejs -y &>>log_file
status_check()

echo -e "${clour} enabling nodejs 18 version \e[0m"
dnf module enable nodejs:18 -y &>>log_file

echo -e "${clour} installing nodejs18 \e[0m"
dnf install nodejs -y &>>log_file
status_check()
echo -e "${clour} installing mysql client \e[0m"
dnf install mysql -y &>>log_file
status_check()
id expense &>>log_file
if [ $? -ne 0 ]; then
echo -e "${clour} adding user \e[0m"
useradd expense &>>log_file
   status_check()
fi
echo -e "${clour} copying backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file
status_check()
if [ ! -d /app ]; then
echo -e "${clour} making a directory for application content to store \e[0m"
mkdir /app &>>log_file
status_check()
fi
echo -e "${clour} removing old application content in app directory and it is free \e[0m"
rm -rf /app/* &>>log_file
status_check()
echo -e "${clour}downloading backend application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
status_check()
echo -e "${clour} changing the directory \e[0m"
cd /app &>>log_file
status_check()
echo -e "${clour} unzipping the application content file in app directory  \e[0m"
unzip /tmp/backend.zip &>>log_file
status_check()
echo -e "${clour} changing the directory\e[0m"
cd /app &>>log_file
status_check()
echo -e "${clour} dowloading dependencies for nodejs software \e[0m"
npm install &>>log_file
status_check()
echo -e "${clour} reloading and starting the nodejs  \e[0m"
systemctl daemon-reload &>>log_file
status_check()
systemctl enable backend &>>log_file
status_check()
systemctl start backend &>>log_file
status_check()
echo -e "${clour} loading schema to mysql client \e[0m"
mysql -h mysql-dev.bharathgaveni.online -uroot -p${MY_SQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>log_file
status_check()