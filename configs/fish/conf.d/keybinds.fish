function fish_user_key_bindings
	bind \cr 'fg >/dev/null 2>&1 || echo -e "\nNo background jobs"; commandline -f repaint'
end
