#!/bin/bash
# https://github.com/tenllado/dotfiles/blob/master/.config/msmtp/oauth2token
# sudo aa-disable /etc/apparmor.d/usr.bin.msmtp
set -euo pipefail

user=$1
host=$2

get_access_token() {
	{ IFS= read -r tokenline && IFS= read -r expireline; } < \
	<(oauth2.py --user=$user \
	--client_id=$(pass neomutt/$host/client_id) \
	--client_secret=$(pass neomutt/$host/client_secret) \
	--refresh_token=$(pass neomutt/$host/refresh_token))

	token=${tokenline#Access Token: }
	expire=${expireline#Access Token Expiration Seconds: }
}

token="$(pass neomutt/$host/token || echo 0)"
expire="$(pass neomutt/$host/token_expiration || echo 0)"
now=$(date +%s)

if [[ $token && $expire && $now -lt $((expire - 60)) ]]; then
	echo $token
else
	get_access_token
	echo $token | pass insert -ef neomutt/$host/token
	expire=$((now + expire))
	echo $expire | pass insert -ef neomutt/$host/token_expiration
	echo $token
fi
