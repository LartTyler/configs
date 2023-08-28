function fish_user_key_bindings
	# Use ctrl+r to resume the first backgrounded process
	bind \cr 'fg >/dev/null 2>&1 || echo -e "\nNo background jobs"; commandline -f repaint'
end
