" Vim syntax file
" Language:         J
" Maintainer:       Georgiy Pruss
" Last Change:      2012-01-28
" add to rc:
" autocmd BufRead *.ijs map <F5> :w<CR>:!C:\BIN\J8\bin\jconsole.exe <C-R>=expand("%:p")<CR><CR><CR>
" au BufNewFile,BufRead *.ijs    setf j

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword jStatement      load loadd require while whilst for
syn keyword jStatement      try catch catcht catchd throw return break continue assert
syn keyword jConditional    if do else elseif end select case fcase
syn match   jConditional    "\<for_[0-9a-z]\+\>"
syn match   jConditional    "\<goto_[0-9a-z]\+\>"
syn match   jConditional    "\<label_[0-9a-z]\+\>"
"syn match  jOperator       "=[.:]"

syn match   jFunction "\(\h\w*\)\( *=[.:] *[1234] \+:\)\@="
syn match   jVariable "\(\h\w*\)\( *=[.:] *0 \+:\)\@="

syn match   jComment  "NB\..*$" contains=jTodo
syn keyword jTodo     FIXME NOTE NOTES TODO XXX contained

syn region  jString   start=+'+ end=+'+
"contains=jSpecial
"syn match  jSpecial  contained "''"

syn match   jNumber   "\<_\?\d\+b[0-9a-z]\+\>"
syn match   jNumber   "\<_\?\d\+\>"
syn match   jNumber   "\<_\>"
syn match   jNumber   "\<_[_.]"
syn match   jNumber   "\<a[:.]"
syn match   jNumber   "\<_\?\d\+[eE]_\?\d\+\>"
"syn match  jNumber   "\<0[oO]\=\o\+[Ll]\=\>"
"syn match  jNumber   "\<0[xX]\x\+[Ll]\=\>"
"syn match  jNumber   "\<\%([1-9]\d*\|0\)[Ll]\=\>"
"syn match  jNumber   "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
"syn match  jNumber   "\%(^\|\W\)\@<=\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"

"syn keyword jBuiltin do assert break -- in jStatement
syn keyword jBuiltin  jpath jpathsep jcwdpath jsystemdefs
syn keyword jBuiltin  IF64 IFGTK IFJHS IFJ6 IFWINE IFWIN IFUNIX UNAME
syn keyword jBuiltin  CR LF TAB FF DEL EAV LF2 CRLF EMPTY empty Debug
syn keyword jBuiltin  apply def define drop each echo exit every getenv inv items fetch
syn keyword jBuiltin  leaf nameclass namelist on pick rows stdout stderr stdin sign sort
syn keyword jBuiltin  verb dyad monad take bind boxopen boxxopen clear cutLF cutopen
syn keyword jBuiltin  erase expand inverse dfh hfd isutf8 list Csize datatype type nl names Note
syn keyword jBuiltin  script scriptd sminfo smoutput tmoutput split table timex timespacex
syn keyword jBuiltin  toupper tolower ucp ucpcount utf8 uucp toJ toCRLF toHOST
syn keyword jBuiltin  coclass cocreate cocurrent codestroy coerase coname conames cofullname
syn keyword jBuiltin  coinsert conew conl copath coreset cofind cofindv coinfo costate
syn keyword jBuiltin  conouns conounsx copathnl copathnlx coselect_result
syn keyword jBuiltin  cd memr memw mema cdf cder cderx symget symset cdcb
syn keyword jBuiltin  JB01 JCHAR JSTR JINT JPTR JFL JCMPX JBOXED JTYPES JSIZES ic fc endian
syn keyword jBuiltin  AND OR XOR DLL_PATH find_dll setbreak
syn keyword jBuiltin  calendar getdate isotimestamp todate todayno tsdiff tsrep timestamp tstamp
syn keyword jBuiltin  valdate weekday weeknumber weeksinyear
"syn keyword jBuiltin dbr dbs dbsq dbss dbrun dbnxt dbret dbjmp dbsig dbrr dbrrx dberr dberm
"syn keyword jBuiltin dblxq dblxs dbtrace dbq dbst dbctx dbg dblocals dbstack dbstk
"syn keyword jBuiltin dbstop dbstops dbstopme dbstopnext dbview
syn keyword jBuiltin  dir dircompare dircompares dirfind dirpath dirss dirssrplc dirtree dirused
syn keyword jBuiltin  fboxname fexists f2utf8 fappend fappends fapplylines fcopynew fdir ferase
syn keyword jBuiltin  fexist fgets fmakex fpathcreate fpathname freadblock fread freads freadr
syn keyword jBuiltin  frename freplace fssrplc fstamp fputs ftype fsize fss fview fstringreplace
syn keyword jBuiltin  fwrite fwritenew fwrites ftostring fstring install quote
syn keyword jBuiltin  cuts cut deb debc delstring detab dlb dltb dtb dltbs dtbs dquote ss
syn keyword jBuiltin  splitstring joinstring ljust rjust dropto dropafter taketo takeafter charsub
syn keyword jBuiltin  chopstring rplc splitnostring stringreplace cutpara foldtext foldpara topara
"in _j_ locale:
"syn keyword jBuiltin Alpha Num AlphaNum Boxes ScriptExt ProjExt extnone extproj extsrc addfname
"syn keyword jBuiltin boxdraw hostcmd fpath maxrecent pack pdef seldir spath termLF termsep
"syn keyword jBuiltin tolist remsep path2proj filecase isroot dirtreex getfolderdefs isconfigfile
"syn keyword jBuiltin isdir istempname istempscript jshowconsole mkdir rmdir newtempscript
"syn keyword jBuiltin nounrep nounrep1 nounrep2 octal scripts setfolder subdirtree tofoldername
"syn keyword jBuiltin unixshell unixshellx htmlhelp browseref browse dfltbrowser xedit
"syn keyword jBuiltin cutnames Cwh getscripts getpath exist fullname
syn keyword jBuiltin  xedit htmlhelp browseref browse viewpdf

if version >= 508 || !exists("did_j_syn_inits")
  if version < 508
    let did_j_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default highlight links.  Can be overridden later.
  HiLink jStatement    Statement
  HiLink jConditional  Conditional
  HiLink jOperator     Operator
  HiLink jFunction     Type
  HiLink jVariable     Type
  HiLink jComment      Comment
  HiLink jTodo         Todo
  HiLink jString       String
  HiLink jSpecial      Special
  HiLink jNumber       Number
  HiLink jBuiltin      Function

  delcommand HiLink
endif

let b:current_syntax = "j"

" vim:set sw=2 sts=2 ts=8:
