# See ./conf.d for additional configs

# Borrowed from https://github.com/jonhoo/configs/blob/master/shell/.config/fish/config.fish
function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "

	set_color blue
	echo -n (hostname)

	if [ $PWD != $HOME ]
		set_color brblack
		echo -n ":"

		set_color yellow
		echo -n (basename $PWD)
	end

	set_color green
	printf '%s ' (__fish_git_prompt)

	set_color red

	if test $COLUMNS -le 80
		echo -en '\n> '
	else
		echo -n '| '
	end

	set_color normal
end

set fish_greeting
