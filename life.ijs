NB. Conway's Game of Life in less than 140 chars (i.e. for twitter)

NB. sum of 3x3 neighbour cells including itself
sum =: 3 3(([:+/+/);._3)0,~0,0,.~0,.] NB. [:+/+/ --> +/&,

NB. life rules: 1->1 if 2 or 3; 0->1 if 3 around, i.e. 1 if sum=3 or self&sum=4
rule =: [:+./(1,:])*.3 4="0 _ sum
rule =: [:+./(1,:])*.3 4(="0 _)3 3(+/&,;._3)0,~0,0,.~0,.]

NB. one step with output
step =: ([echo&<)&rule

NB. random field of dimension y (rows cols)
fld =: ?@$&2

NB. simulate life 20 times, field 10x90 (good for console)
0 0$ step^:20 fld 10 90

NB. oneliner:
0 0$(([echo&<&({&' #'))&([:+./(1,:])*.3 4(="0 _)3 3(+/&,;._3)0,~0,0,.~0,.]))^:20?2$~10 90
