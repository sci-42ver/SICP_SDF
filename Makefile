format:
	# https://unix.stackexchange.com/a/732101/568529
	find ~/SICP -regextype posix-egrep -regex ".*.(scm|rkt)" | grep -E -v "sdf|/[1-5]_[a-zA-Z]" | xargs -o -I{} vim -c "execute 'normal gg=G' | update | quitall" {}
