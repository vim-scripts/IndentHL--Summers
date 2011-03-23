" indenthl.vim: hilights each indent level in different colors.

" Author: Dane Summers
" Date: March 23, 2011
"
" See :help mysyntaxfile-add for how to install this file.

" Options"{{{

" When SET: will infer what is 'error' hilighting and what isn't:
"    When the expandtab option is set: NO TABS should be at the beginning of
"    the line. Any lines with tabs in the beginning whitespace will be hilighted
"    as cTabError
"    When the expandtab is not set: TABS are expected at the beginning of the 
"    line. Any lines beginning with non-TAB whitespace will be hilighted
"    as cTabError.
" When NOT SET: hilighting will just hilight TABs as indents (original
" behavior of this plugin).
if !exists('g:indenthlinfertabmode') | let g:indenthlinfertabmode = 0 | endif

" When SET: Will hilight any combinations of tabs and spacing at the beginning
" of the line as cTabError (defualt RED)
if !exists('g:indenthlshowerrors') | let g:indenthlshowerrors = 0 | endif

" Style of hilighting. Three styles:
" 1: to make colors slightly darker at each level (in gui)
" 2: all alternating colors:
" 3: all alternating colors, but it gets darker with each alternate:
if !exists('g:indenthlstyle') | let g:indenthlstyle = 3 | endif

"}}}
" Hilightings"{{{
"
" This style matching would be more efficient, but apparently the \zs can't
" look into regions matched by other patterns (in this example the cTab1 match
" prevents the \zs from matching starting at the second tab):
" syn match cTab2 /^\t\zs\t/
"
if (g:indenthlinfertabmode)
  if (&et)
    exec 'syn match cTab1 /^ \{'. &sw .'}/'
    exec 'syn match cTab2 /\(^ \{'. &sw   .'}\)\@<= \{'. &sw .'}/'
    exec 'syn match cTab3 /\(^ \{'. &sw*2 .'}\)\@<= \{'. &sw .'}/'
    exec 'syn match cTab4 /\(^ \{'. &sw*3 .'}\)\@<= \{'. &sw .'}/'
    exec 'syn match cTab5 /\(^ \{'. &sw*4 .'}\)\@<= \{'. &sw .'}/'
    exec 'syn match cTab6 /\(^ \{'. &sw*5 .'}\)\@<= \{'. &sw .'}/'
    exec 'syn match cTab7 /\(^ \{'. &sw*6 .'}\)\@<= \{'. &sw .'}/'
    syn match cTabError /^\t\+/
  else
    syn match cTab1 /^[\t]/
    syn match cTab2 /\(^\t\)\@<=\t/
    syn match cTab3 /\(^\t\{2}\)\@<=\t/
    syn match cTab4 /\(^\t\{3}\)\@<=\t/
    syn match cTab5 /\(^\t\{4}\)\@<=\t/
    syn match cTab6 /\(^\t\{5}\)\@<=\t/
    syn match cTab7 /\(^\t\{6}\)\@<=\t/
    syn match cTabError /^ \+/
  endif
else
  syn match cTab1 /^[\t]/
  syn match cTab2 /\(^\t\)\@<=\t/
  syn match cTab3 /\(^\t\{2}\)\@<=\t/
  syn match cTab4 /\(^\t\{3}\)\@<=\t/
  syn match cTab5 /\(^\t\{4}\)\@<=\t/
  syn match cTab6 /\(^\t\{5}\)\@<=\t/
  syn match cTab7 /\(^\t\{6}\)\@<=\t/
endif

syn match cTabError /^ \+\t\+/
syn match cTabError /^\t\+ \+/

" examples of all combinations of spaces and tabs (for debugging):
		
   
  	
 	 
	  
	 	

command! -nargs=+ HiLink hi def <args>

" Pick one of three options (see
" http://viming.blogspot.com/2007/02/indent-level-highlighting.html for
" screenshots of the three options):

if (g:indenthlstyle == 1)
  " ONE: to make colors slightly darker at each level (in gui)
  HiLink cTab1 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray90
  HiLink cTab2 term=NONE cterm=NONE ctermbg=gray gui=NONE guibg=gray85
  HiLink cTab3 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray80
  HiLink cTab4 term=NONE cterm=NONE ctermbg=gray gui=NONE guibg=gray75
  HiLink cTab5 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray70
  HiLink cTab6 term=NONE cterm=NONE ctermbg=gray gui=NONE guibg=gray65
  HiLink cTab7 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=gray60
elseif (g:indenthlstyle == 2)
  " TWO: all alternating colors:
  HiLink cTab1 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
  HiLink cTab2 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
  HiLink cTab3 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
  HiLink cTab4 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
  HiLink cTab5 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
  HiLink cTab6 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
  HiLink cTab7 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
elseif (g:indenthlstyle == 3)
  " THREE: all alternating colors, but it gets darker with each alternate:
  HiLink cTab1 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
  HiLink cTab2 term=NONE cterm=NONE ctermbg=lightgray gui=NONE guibg=gray95
  HiLink cTab3 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
  HiLink cTab4 term=NONE cterm=NONE ctermbg=brown gui=NONE guibg=gray85
  HiLink cTab5 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
  HiLink cTab6 term=NONE cterm=NONE ctermbg=blue gui=NONE guibg=gray75
  HiLink cTab7 term=NONE cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
else
  echoe "indenthl: No such syntax style '". g:indenthlstyle ."' - use 1,2, or 3"
endif

" Error hilighting:
if (g:indenthlshowerrors)
  HiLink cTabError term=NONE cterm=NONE ctermbg=Red gui=NONE guibg=Red
endif

delcommand HiLink
"}}}
" vim: set fdm=marker:
