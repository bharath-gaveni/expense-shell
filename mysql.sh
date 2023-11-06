source common.sh
if [ -z "$1" ]; then
  echo provide password
  exit
fi
MY_SQL_ROOT_PASSWORD="$1"
echo -e "${clour} disable mysql \e[0m"
dnf module disable mysql -y &>>log_file
status_check
echo -e "${clour} copying mysql.repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
status_check
echo -e "${clour} installing mysql server \e[0m"
dnf install mysql-community-server -y &>>log_file
status_check
echo -e "${clour} enabling mysqld \e[0m"
systemctl enable mysqld &>>log_file
status_check
echo -e "${clour} stsrting mysqld \e[0m"
systemctl start mysqld &>>log_file
status_check
echo -e "${clour} setting up the password for mysql \e[0m"
mysql_secure_installation --set-root-pass ${MY_SQL_ROOT_PASSWORD} &>>log_file
status_check