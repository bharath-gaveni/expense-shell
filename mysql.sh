

log_file="/tmp/expense.log"
clour="\e[36m"
echo -e "${clour} disable mysql \e[0m"
dnf module disable mysql -y &>>log_file
echo $?
echo -e "${clour} copying mysql.repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
echo $?
echo -e "${clour} installing mysql server \e[0m"
dnf install mysql-community-server -y &>>log_file
echo $?
echo -e "${clour} enabling mysqld \e[0m"
systemctl enable mysqld &>>log_file
echo $?
echo -e "${clour} stsrting mysqld \e[0m"
systemctl start mysqld &>>log_file
echo $?
echo -e "${clour} setting up the password for mysql \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
echo $?