NB. color output in Windows console

'std_input_handle std_out_handle std_err_handle'=:'kernel32 GetStdHandle >i x'&cd"0(-10 11 12)

set_pos =: 3 : 0  NB. [handle] set_pos row;col (or row,col)
  std_out_handle set_pos y
:
  'row col'=.y
  'kernel32 SetConsoleCursorPosition >i x x' cd x;col+row*65536
)

set_clr =: 3 : 0  NB. [handle] set_clr color
std_out_handle set_clr y
:
'kernel32 SetConsoleTextAttribute >i x x' cd x;y
)
0 : 0
FG_B  = 0x01 # text color contains blue.
FG_G  = 0x02 # text color contains green.
FG_R  = 0x04 # text color contains red.
FG_HI = 0x08 # text color is intensified.
BG_B  = 0x10 # background color contains blue.
BG_G  = 0x20 # background color contains green.
BG_R  = 0x40 # background color contains red.
BG_HI = 0x80 # background color is intensified.
)

sc =: 3 : 0  NB. [bg] sc fg (or sc bg,fg)
  'k' sc y
:
  if. 2=#y do. 'bg fg'=.y else. bg=.x [ fg=.y end.
  f =. 'kbgcrmywKBGCRMYW' i. fg
  if. f>15 do. f=.11 end.
  b =. 'kbgcrmywKBGCRMYW' i. bg
  if. b>15 do. b=.0 end.
  set_clr f+b*16
  0 0$0
)

NB. 1!:2(4) prints w/o ending LF
NB. sc 'w' [ 'world!' 1!:2(2) [ sc 'Wb' [ 'hello ' 1!:2(4) [ sc 'bY'
