# vim: ft=neomuttrc

set my_domain="suse.com"
set realname="Ricardo B. Marliere"
set from="rbm@suse.com"
set sendmail="msmtp -a suse.com"

source "~/.config/neomutt/gmail"
