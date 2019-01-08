#!/bin/bash

file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'MYSQL_PASSWORD'
sed -i -e 's/#include snippets\/'$SNIPPET'\.conf;/include snippets\/'$SNIPPET'.conf;/g' /etc/nginx/conf.d/default.conf
sed -i -e 's@set \$htdocs.*@set \$htdocs '$WEBROOT';@g' /etc/nginx/conf.d/default.conf
nginx -g "daemon off;"