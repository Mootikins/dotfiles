" wpgtk alternate Airline Theme
let g:airline#themes#wpgtk_alternate_true#palette = {{}}

" Normal mode
let s:N  = [ "{color0}", "{color12}", 'NONE', 'NONE', 'BOLD' ]
let s:N2 = [ "{color0}", "{color10}", 'NONE', 'NONE', 'NONE' ]
let s:N3 = [ "{color12}", "{color8}", 'NONE', 'NONE', 'NONE' ]

" Insert mode
let s:I  = [ "{color0}", "{color13}", 'NONE', 'NONE', 'BOLD' ]
let s:I2 = [ "{color0}", "{color10}", 'NONE', 'NONE', 'NONE' ]
let s:I3 = [ "{color10}", "{color8}", 'NONE', 'NONE', 'NONE' ]

" Visual mode
let s:V  = [ "{color0}", "{color9}", 'NONE', 'NONE', 'BOLD' ]
let s:V2 = [ "{color0}", "{color10}", 'NONE', 'NONE', 'NONE' ]
let s:V3 = [ "{color9}", "{color8}", 'NONE', 'NONE', 'NONE' ]

" Replace mode
let s:R  = [ "{color0}", "{color13}", 'NONE', 'NONE', 'BOLD' ]
let s:R2 = [ "{color0}", "{color10}", 'NONE', 'NONE', 'NONE' ]
let s:R3 = [ "{color13}", "{color8}", 'NONE', 'NONE', 'NONE' ]

let g:airline#themes#wpgtk_alternate_true#palette.normal  = airline#themes#generate_color_map(s:N, s:N2, s:N3)
let g:airline#themes#wpgtk_alternate_true#palette.insert  = airline#themes#generate_color_map(s:I, s:I2, s:I3)
let g:airline#themes#wpgtk_alternate_true#palette.visual  = airline#themes#generate_color_map(s:V, s:V2, s:V3)
let g:airline#themes#wpgtk_alternate_true#palette.replace = airline#themes#generate_color_map(s:R, s:R2, s:R3)

let g:airline#themes#wpgtk_alternate_true#palette.accents = {{ 'red': [ "{color0}", "{color2}", 'NONE', 'NONE', 'BOLD' ] }}

" Inactive mode
let s:IN1 = [ "{color12}", "{color8}", 'NONE', 'NONE' ]
let s:IN2 = [ "{color8}", "{color12}", 'NONE', 'NONE' ]

let s:IA = [ s:IN1[1], s:IN2[1], s:IN1[2], s:IN2[3], 'NONE' ]
let g:airline#themes#wpgtk_alternate_true#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

" Warnings
let s:WI = [ "{color0}", "{color7}", 'NONE', 'NONE', 'BOLD' ]
let g:airline#themes#wpgtk_alternate_true#palette.normal.airline_warning  = s:WI
let g:airline#themes#wpgtk_alternate_true#palette.insert.airline_warning  = s:WI
let g:airline#themes#wpgtk_alternate_true#palette.visual.airline_warning  = s:WI
let g:airline#themes#wpgtk_alternate_true#palette.replace.airline_warning = s:WI

let g:airline#themes#wpgtk_alternate_true#palette.normal.airline_error  = s:WI
let g:airline#themes#wpgtk_alternate_true#palette.insert.airline_error  = s:WI
let g:airline#themes#wpgtk_alternate_true#palette.visual.airline_error  = s:WI
let g:airline#themes#wpgtk_alternate_true#palette.replace.airline_error = s:WI

" Tabline
let g:airline#themes#wpgtk_alternate_true#palette.tabline = {{
      \ 'airline_tab':     [ "{color12}", "{color8}", 'NONE', 'NONE', 'BOLD' ],
      \ 'airline_tabsel':  [ "{color0}", "{color12}", 'NONE', 'NONE', 'BOLD' ],
      \ 'airline_tabtype': [ "{color0}", "{color12}", 'NONE', 'NONE', 'BOLD' ],
      \ 'airline_tabfill': [ "{color12}", "{color8}", 'NONE', 'NONE', 'BOLD' ],
      \ 'airline_tabmod':  [ "{color0}", "{color12}", 'NONE', 'NONE', 'BOLD' ]
\ }}

if !get(g:, 'loaded_ctrlp', 0)
  finish
endif

let g:airline#themes#wpgtk_alternate_true#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ "{color0}", "{color0}", 'NONE', 'NONE', 'BOLD' ],
      \ [ "{color0}", "{color0}", 'NONE', 'NONE', 'BOLD' ],
      \ [ "{color0}", "{color0}", 'NONE', 'NONE', 'BOLD' ] )
