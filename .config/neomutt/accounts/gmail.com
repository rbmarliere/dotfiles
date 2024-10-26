# vim: ft=neomuttrc

set hostname=gmail.com
set realname="Ricardo B. Marliere"
set from="rbmarliere@gmail.com"
set sendmail="msmtp -a gmail.com"

source "~/.config/neomutt/gmail"
