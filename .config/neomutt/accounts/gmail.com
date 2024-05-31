# vim: ft=neomuttrc

set realname="Ricardo B. Marliere"
set from="rbmarliere@gmail.com"
set sendmail="msmtp -a gmail.com"

set folder="imaps://$from@imap.gmail.com:993"
set postponed="+[Gmail]/Drafts"
set record="+[Gmail]/Sent Mail"
set spoolfile="+INBOX"
set trash="+[Gmail]/Trash"

set imap_user="$from"
set imap_authenticators="oauthbearer"
set imap_oauth_refresh_command="~/.local/bin/oauth2.py --quiet --user=rbmarliere@gmail.com --client_id=`pass neomutt/client_id` --client_secret=`pass neomutt/client_secret` --refresh_token=`pass neomutt/refresh_token`"
