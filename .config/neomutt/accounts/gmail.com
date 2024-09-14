# vim: ft=neomuttrc

set my_domain="gmail.com"
set realname="Ricardo B. Marliere"
set from="rbmarliere@gmail.com"
set sendmail="msmtp -a gmail.com"

source "~/.config/neomutt/gmail"
