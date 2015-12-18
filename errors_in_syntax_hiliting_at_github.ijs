NB. wrong id, wrong numbers

goodid =. 1
bad8id =. 2 NB. multi-colored id :(
bad_ints =. 2b01010101 16b1000 16bffff NB. 85 4096 65535
bad_floats =. 1p1 1x1 NB. 3.14159 2.71828
bad_ratios =. 1r3 1.5r8 NB. 0.333333 0.1875
bad_extended =. 123456789123456789123456789x
bad_complexs =. _j_ 1j2p1 _3.7x_2j_5e_4
others =. _ __ _. ; a:
foo =. 3 : 0
  for_i. i.20 do. echo i end. NB. for_i. or at least for_ must be hilited
  label_L. goto_L. try. catch. catchd. catcht. throw.
  assert. select. case. fcase. for. break. continue. return.
  while. whilst. if. else. elseif. do. end. NB. these are ok
)
