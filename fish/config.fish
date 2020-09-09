if not functions -q fisher
	echo "Fisher is not installed. Run `install-fisher`."
end

# notify when a command ran for 15 seconds
set -g __done_min_cmd_duration 15000

# Make GnuPG work correctly
set -gx GPG_TTY (tty)

if type -q starship
	starship init fish | source
else
	echo "Starship is not installed" 1>&2
end

if type -q thefuck
	thefuck --alias | source
else
	echo "thefuck is not installed" 1>&2
end
