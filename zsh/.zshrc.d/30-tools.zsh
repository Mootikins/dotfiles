# Tool-specific configurations

# eza/exa aliases
if type eza &>/dev/null; then
	alias ls=eza
	alias la="eza -a"
	alias ll="eza -l"
fi

# Go configuration
if type go &>/dev/null; then
	export GOPATH=$(go env GOPATH)
fi

# Delta configuration for git
__delta_side_by_side_width() {
	local columns=$(tput cols)
	# Enough room for two side-by-side 80-char diffs with some room for line numbers to spare
	if [ $columns -ge 170 ]; then
		export DELTA_FEATURES="+side-by-side"
	else
		export DELTA_FEATURES=""
	fi
}

precmd() {
	__delta_side_by_side_width
}