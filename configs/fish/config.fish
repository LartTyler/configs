# See ./conf.d for additional configs

# Common environment variables
set -gx EDITOR nvim
set -gx BROWSER firefox
set -gx LESS "-F -X -R"

# Rust environment variables
set -gx CARGO_TARGET_DIR ~/.cargo-target
set -gx CARGO_INCREMENTAL 1
set -gx RUSTFLAGS "-C target-cpu=native"
set -gx RUST_BACKTRACE 1

# PATH settings
fish_add_path -P ~/.cargo/bin
fish_add_path -P ~/.local/bin
fish_add_path -P ~/.npm-packages/bin

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
