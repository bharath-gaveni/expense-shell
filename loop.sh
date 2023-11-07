a=10
while [ "$a" -gt 0 ]; do
  echo dakati
  a=$(("$a"-1))
  sleep 1
done


for dakati in bharath kumar gaveni; do
  echo dakati is - $dakati
  sleep 1
done

root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
