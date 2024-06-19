function preview -a "filename"
	set -l ext (path extension "$filename")
	set -l mimetype "$(file --dereference --mime-type "$filename")"
	if [ "$ext" = ".md" ]
		glow --style dark "$filename"
		return
	end
	switch "$mimetype"
		case "*directory*"
			tree -C -L 1 "$filename"
		case "*"
			bat -n --color always "$filename"
	end
end