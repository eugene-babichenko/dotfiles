function fzf_preview -a "filename"
	set -l mimetype "$(file --brief --dereference --mime-type "$filename")"
	switch "$mimetype"
		case "*directory*"
			tree -C -L 1 "$filename"
		case "*"
			bat -n --color always "$filename"
	end
end
