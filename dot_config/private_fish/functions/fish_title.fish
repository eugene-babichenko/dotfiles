function fish_title
	if test "$_" != 'fish'
		echo "$argv"
		return
	end
	echo 'fish '
	prompt_pwd
end
