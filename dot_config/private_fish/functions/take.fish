function take -a "filename"
	if test -n "$filename"
		mkdir -p "$filename" && cd "$filename"
	else
		echo "you should provide a directory name"
		return 1
	end
end
