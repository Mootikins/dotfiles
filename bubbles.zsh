# No surrounding whitespace.
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=' '
# Separator between same-color segments on the left.
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%k%F{$POWERLEVEL9K_BACKGROUND}\uE0B4%k \uE0B6"
# Separator between same-color segments on the right.
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR="%k%F{$POWERLEVEL9K_BACKGROUND}\uE0B4%k \uE0B6"
# Separator between different-color segments on the left.
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
# Separator between different-color segments on the right.
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=' \uE0B6'
# The right end of left prompt.
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
# The left end of right prompt.
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
# The left end of left prompt.
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
# The right end of right prompt.
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
# Left prompt terminator for lines without any segments.
typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
