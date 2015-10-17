load 'tjd.ijs'

assert 0 0 1 1 1 -: is_ut_dn 585 + i.5
assert 1 1 1 0 0 -: is_ut_dn 25439 + i.5
assert 0 0 1 1 1 -: is_ut_year 1968 + i.5
assert 1 1 1 0 0 -: is_ut_year 2036 + i.5
assert 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 -: is_leap_year 1995 + i.15
assert 31 29 31 30 31 30 31 31 30 31 30 31 -: (1+i.12) days_in_month"0 (2008)
assert 31 28 31 30 31 30 31 31 30 31 30 31 -: (1+i.12) days_in_month"0 (2009)
assert 0 -: is_valid_ymd 2015  1  0
assert 0 -: is_valid_ymd 2015  0  1
assert 1 -: is_valid_ymd 2015  1  1
assert 1 -: is_valid_ymd 2015 12 31
assert 0 -: is_valid_ymd 2015 12 32
assert 0 -: is_valid_ymd 2015 13 31

assert _140840 -: dn4ymd 1582 10 15
assert _134187 -: dn4ymd 1601 01 01 NB. ANSI COBOL 85 & Quattro Pro Day 1. MS filedate
assert _100000 -: dn4ymd 1694 08 08
assert  _99999 -: dn4ymd 1694 08 09
assert  _61504 -: dn4ymd 1800 01 01
assert  _46529 -: dn4ymd 1841 01 01 NB. ANSI MUMPS $Horolog Day 1
assert  _40000 -: dn4ymd 1858 11 17 NB. MJD 0, CJD 2400001
assert  _32768 -: dn4ymd 1878 09 05
assert  _24980 -: dn4ymd 1900 01 01
assert   _1023 -: dn4ymd 1965 08 05
assert       0 -: dn4ymd 1968 05 24 NB. Fr (tjd+5)%7
assert       1 -: dn4ymd 1968 05 25 NB. Sa
assert     587 -: dn4ymd 1970 01 01
assert    9999 -: dn4ymd 1995 10 09
assert   13735 -: dn4ymd 2005 12 31
assert   13965 -: dn4ymd 2006 08 18
assert   16383 -: dn4ymd 2013 04 01
assert   19999 -: dn4ymd 2023 02 24
assert   25441 -: dn4ymd 2038 01 18
assert   32767 -: dn4ymd 2058 02 08
assert   48433 -: dn4ymd 2100 12 31
assert   50000 -: dn4ymd 2105 04 16
assert   65535 -: dn4ymd 2147 10 28
assert   99999 -: dn4ymd 2242 03 08
assert _1084193-: dn4ymd _1000 1 01
assert _1000000-: dn4ymd _770 07 05
assert  194530 -: dn4ymd 2500 12 31
assert  200000 -: dn4ymd 2515 12 23
assert _2440001-: dn4ymd _4712 1 01 NB. 4713BC JD 0 started at noon
assert _718578 -: dn4ymd 0000 12 31 NB. 1BC Julian -- B.C. ended
assert _718577 -: dn4ymd 0001 01 01 NB. 1AD Julian -- A.D. start
NB. See http://www.merlyn.demon.co.uk/critdate.htm for other dates

assert 4 4 -: (wd4dn,wd_4dn) dn4ymd 1965 08 05
assert 5 5 -: (wd4dn,wd_4dn) dn4ymd 1968 05 24
assert 6 6 -: (wd4dn,wd_4dn) dn4ymd 1968 05 25
assert 0 7 -: (wd4dn,wd_4dn) dn4ymd 1968 05 26
assert 1 1 -: (wd4dn,wd_4dn) dn4ymd 1995 10 09
assert 6 6 -: (wd4dn,wd_4dn) dn4ymd 2005 12 31
assert 5 5 -: (wd4dn,wd_4dn) dn4ymd 2006 08 18
assert 3 3 -: (wd4dn,wd_4dn) dn4ymd 2015 04 22

assert 1 1 -: (wd4dn,wd_4dn) dn4ymd _4712 1 01
assert 5 5 -: (wd4dn,wd_4dn) dn4ymd 0000 12 31
assert 6 6 -: (wd4dn,wd_4dn) dn4ymd 0001 01 01

assert 0 7 -: (wd4dn,wd_4dn) dn4ymd 0030 04 09 NB. Resurrection of Christ

assert 1 1 -: (wd4dn,wd_4dn) dn4ymd 1601  1  1
assert 1 1 -: (wd4dn,wd_4dn) dn4ymd 1694  8  9
assert 5 5 -: (wd4dn,wd_4dn) dn4ymd 1841  1  1
assert 3 3 -: (wd4dn,wd_4dn) dn4ymd 1858 11 17
assert 4 4 -: (wd4dn,wd_4dn) dn4ymd 1878  9  5
assert 4 4 -: (wd4dn,wd_4dn) dn4ymd 1970  1  1
assert 1 1 -: (wd4dn,wd_4dn) dn4ymd 2013  4  1
assert 5 5 -: (wd4dn,wd_4dn) dn4ymd 2023  2 24
assert 1 1 -: (wd4dn,wd_4dn) dn4ymd 2038  1 18
assert 5 5 -: (wd4dn,wd_4dn) dn4ymd 2058  2  8
assert 6 6 -: (wd4dn,wd_4dn) dn4ymd 2147 10 28
assert 2 2 -: (wd4dn,wd_4dn) dn4ymd 2242  3  8

assert 1899 12 12 -: ymd4dn _25000
assert 1968 05 24 -: ymd4dn 0
assert 1968 05 25 -: ymd4dn 1
assert 1970 01 01 -: ymd4dn 587
assert 1995 10 09 -: ymd4dn 9999
assert 2515 12 23 -: ymd4dn 200000

assert 1582 10  4  4 -: (ymd4dn,wd4dn) dn4ymd 1582 10  4 NB. same

assert 1582 10 15  5 -: (ymd4dn,wd4dn) dn4ymd 1582 10  5 NB. skip
assert 1582 10 16  6 -: (ymd4dn,wd4dn) dn4ymd 1582 10  6 NB. i.e.
assert 1582 10 17  0 -: (ymd4dn,wd4dn) dn4ymd 1582 10  7 NB. Oct.5..14
assert 1582 10 18  1 -: (ymd4dn,wd4dn) dn4ymd 1582 10  8 NB. mapped
assert 1582 10 19  2 -: (ymd4dn,wd4dn) dn4ymd 1582 10  9 NB. to new/real
assert 1582 10 20  3 -: (ymd4dn,wd4dn) dn4ymd 1582 10 10 NB. Oct.15..24
assert 1582 10 21  4 -: (ymd4dn,wd4dn) dn4ymd 1582 10 11
assert 1582 10 22  5 -: (ymd4dn,wd4dn) dn4ymd 1582 10 12 NB. dn4ymd
assert 1582 10 23  6 -: (ymd4dn,wd4dn) dn4ymd 1582 10 13 NB. does not test
assert 1582 10 24  0 -: (ymd4dn,wd4dn) dn4ymd 1582 10 14 NB. for valid m/d

assert 1582 10 15  5 -: (ymd4dn,wd4dn) dn4ymd 1582 10 15 NB. repeat last
assert 1582 10 16  6 -: (ymd4dn,wd4dn) dn4ymd 1582 10 16 NB. ten days...

assert 0.05 > | moonphase4jd jd4dnf 0.9 + dn4ymd 2015 4 18
assert 17 = <. moonphase4jd jd4dnf dn4ymd 30 4 9 NB. Full+2..3

assert 2015 2  1 -: ymd4dn 1 0 nth_day_of_month 2015 2
assert 2015 2  2 -: ymd4dn 1 1 nth_day_of_month 2015 2
assert 2015 2  3 -: ymd4dn 1 2 nth_day_of_month 2015 2
assert 2015 2  4 -: ymd4dn 1 3 nth_day_of_month 2015 2
assert 2015 2  5 -: ymd4dn 1 4 nth_day_of_month 2015 2
assert 2015 2  6 -: ymd4dn 1 5 nth_day_of_month 2015 2
assert 2015 2  7 -: ymd4dn 1 6 nth_day_of_month 2015 2
assert 2015 2  8 -: ymd4dn 2 0 nth_day_of_month 2015 2
assert 2015 2  9 -: ymd4dn 2 1 nth_day_of_month 2015 2
assert 2015 2 10 -: ymd4dn 2 2 nth_day_of_month 2015 2
assert 2015 2 11 -: ymd4dn 2 3 nth_day_of_month 2015 2
assert 2015 2 12 -: ymd4dn 2 4 nth_day_of_month 2015 2
assert 2015 2 13 -: ymd4dn 2 5 nth_day_of_month 2015 2
assert 2015 2 14 -: ymd4dn 2 6 nth_day_of_month 2015 2
assert 2015 2 15 -: ymd4dn 3 0 nth_day_of_month 2015 2
assert 2015 2 16 -: ymd4dn 3 1 nth_day_of_month 2015 2
assert 2015 2 17 -: ymd4dn 3 2 nth_day_of_month 2015 2
assert 2015 2 18 -: ymd4dn 3 3 nth_day_of_month 2015 2
assert 2015 2 19 -: ymd4dn 3 4 nth_day_of_month 2015 2
assert 2015 2 20 -: ymd4dn 3 5 nth_day_of_month 2015 2
assert 2015 2 21 -: ymd4dn 3 6 nth_day_of_month 2015 2
assert 2015 2 22 -: ymd4dn 4 0 nth_day_of_month 2015 2
assert 2015 2 23 -: ymd4dn 4 1 nth_day_of_month 2015 2
assert 2015 2 24 -: ymd4dn 4 2 nth_day_of_month 2015 2
assert 2015 2 25 -: ymd4dn 4 3 nth_day_of_month 2015 2
assert 2015 2 26 -: ymd4dn 4 4 nth_day_of_month 2015 2
assert 2015 2 27 -: ymd4dn 4 5 nth_day_of_month 2015 2
assert 2015 2 28 -: ymd4dn 4 6 nth_day_of_month 2015 2
assert 2015 2 22 -: ymd4dn 0 0 nth_day_of_month 2015 2
assert 2015 2 23 -: ymd4dn 0 1 nth_day_of_month 2015 2
assert 2015 2 24 -: ymd4dn 0 2 nth_day_of_month 2015 2
assert 2015 2 25 -: ymd4dn 0 3 nth_day_of_month 2015 2
assert 2015 2 26 -: ymd4dn 0 4 nth_day_of_month 2015 2
assert 2015 2 27 -: ymd4dn 0 5 nth_day_of_month 2015 2
assert 2015 2 28 -: ymd4dn 0 6 nth_day_of_month 2015 2

echo 'OK'

3 : 0 [ _1000 2500 _1000000 200000
  E =. 3 : 'echo y' NB. can be 'y'
  'Y1 Y2 J1 J2' =. y
  E 'ymd <- ymd4dn <- dn4ymd <- ymd; ',(":Y1),'.1.1 to ',(":Y2),'.12.31'
  E 'assert the days go sequentially one by one without skips'
  dn =. <:dn4ymd Y1,1 1
  wd =. wd4dn dn
  E (>:dn),Y1,1,1
  for_year. Y1+i.>:Y2-Y1 do.
    if. 0=100|year do. E year end.
    for_month. 1+i.12 do.
      for_day. 1+i.31 do.
        if. is_valid_ymd year,month,day do.
          nn =. dn4ymd year,month,day
          ww =. wd4dn nn
          assert nn = dn+1
          assert ww = 7|wd+1
          ymd =. ymd4dn nn
          assert ymd -: year,month,day
          dn =. nn
          wd =. ww
        end.
      end.
    end.
  end.
  E dn,Y2,12,31
  E ''
  E 'dn -: dn4ymd ymd4dn dn; ',(":J1),'..',":J2
  E (ymd4dn J1),J1
  for_dn. J1+i.>:J2-J1 do.
    if. 0=50000|dn do. E dn end.
    assert dn -: dn4ymd ymd4dn dn
  end.
  E (ymd4dn J2),J2
)

echo 'OK'
6!:3 [5
exit 0
