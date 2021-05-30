if not functions -q fisher
	echo "Fisher is not installed. Run `install-fisher`."
end

# Make GnuPG work correctly
set -gx GPG_TTY (tty)

if type -q starship
	starship init fish --print-full-init | source
else
	echo "Starship is not installed" 1>&2
end

if type -q thefuck
	codegen-cache thefuck --alias | source
else
	echo "thefuck is not installed" 1>&2
end
