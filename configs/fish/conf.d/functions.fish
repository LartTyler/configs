# Borrowed from https://github.com/jonhoo/configs/blob/master/shell/.config/fish/config.fish
function d
	while test $PWD != "/"
		if test -d .git
			break
		end

		cd ..
	end
end
