function fzf_preview -a "filename"
	set -l mimetype "$(file --dereference --mime-type "$filename")"
	set -l columns (math "round($FZF_PREVIEW_COLUMNS * 0.7)")
	set -l lines (math "round($FZF_PREVIEW_LINES * 0.5)")
	switch "$mimetype"
		case "*directory*"
			tree -C -L 1 "$filename"
		case "*"
			bat -n --color always "$filename"
	end
end
