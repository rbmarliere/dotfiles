# vim: ft=neomuttrc

set my_archive="+[Gmail]/All%20Mail"
set my_spam="+[Gmail]/Spam"

set realname="Ricardo B. Marliere"
set from="rbmarliere@gmail.com"
set sendmail="msmtp -a gmail.com"

set folder="imaps://$from@imap.gmail.com:993"
set postponed="+[Gmail]/Drafts"
unset record
set spoolfile="+INBOX"
set trash="+[Gmail]/Trash"

set imap_user="$from"
set imap_authenticators="oauthbearer"
set imap_oauth_refresh_command="~/.local/bin/oauth2.py --quiet --user=rbmarliere@gmail.com --client_id=`pass neomutt/gmail.com/client_id` --client_secret=`pass neomutt/gmail.com/client_secret` --refresh_token=`pass neomutt/gmail.com/refresh_token`"

folder-hook INBOX "set record=^; push <collapse-all>; set check_new=yes"

