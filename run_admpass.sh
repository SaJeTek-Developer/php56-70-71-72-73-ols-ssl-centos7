#!/usr/bin/expect -f

spawn /usr/local/lsws/admin/misc/admpass.sh
expect "Please input username:"
send "admin\r"
expect "Please input administrator's password:"
send "123456\r"
expect "Retype password:"
send "123456\r"
expect eof
