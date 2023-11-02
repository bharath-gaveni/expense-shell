dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
dnf install mysql -y
useradd expense
cp backend.service /etc/systemd/system/backend.service
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip
cd /app
npm install
systemctl daemon-reload
systemctl enable backend
systemctl start backend
mysql -h mysql-dev.bharathgaveni.online -uroot -pExpenseApp@1 < /app/schema/backend.sql