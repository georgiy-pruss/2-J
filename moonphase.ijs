NB. see also http://www.calendar-12.com/moon_phases/2015

use 'tjd'

rfd=: 180 %~ o.    NB. Radians from degrees

sind =: 1 o. rfd
cosd =: 2 o. rfd

moon_phase_date =: 4 : 0 NB. x = k; y = phase
  x =. x + y%4
  t3 =. t*t2 =. t*t=. x%1236.85 NB. t is time in 'century' units
  j =. 2415020.75933 + (29.53058868*x) + (0.0001178*t2) - 0.000000155*t3
  j =. j + 0.00033*sind(166.56 + (132.87*t) - 0.009173*t2)
  NB. sun anomaly; moon anomaly; moon latitude:
  sa =. 360|359.2242+(29.10535608*x)+(_0.0000333*t2)+_0.00000347*t3
  ma =. 360|306.0253+(385.81691806*x)+(0.0107306*t2)+0.00001236*t3
  ml =. 360|21.2964+(390.67050646*x)+(_0.0016528*t2)+_0.00000239*t3
  if. (y=2) +. y=0 do. NB. new moon and full moon
    j =. j + ((0.1734-0.000393*t)*sind(sa)) + (0.0021*sind(2*sa))
    j =. j + (_0.4068*sind(ma)) + (0.0161*sind(2*ma)) + (_0.0004*sind(3*ma))
    j =. j + (0.0104*sind(2*ml)) + (_0.0051*sind(sa+ma)) + (_0.0074*sind(sa-ma))
    j =. j + (0.0004*sind(sa+2*ml)) + (0.0004*sind(sa-2*ml))
    j =. j + (_0.0006*sind(ma+2*ml)) + (_0.0010*sind(ma-2*ml)) + (0.0005*sind(sa+2*ma))
  else. NB. y=1 or 3
    j =. j + ((0.1721-0.0004*t)*sind(sa)) + (0.0021*sind(2*sa))
    j =. j + (_0.6280*sind(ma)) + (0.0089*sind(2*ma)) + (_0.0004*sind(3*ma))
    j =. j + (0.0079*sind(2*ml)) + (_0.0119*sind(sa+ma)) + (_0.0047*sind(sa-ma))
    j =. j + (0.0003*sind(sa+2*ml)) + (0.0004*sind(sa-2*ml))
    j =. j + (_0.0006*sind(ma+2*ml)) + (_0.0021*sind(ma-2*ml)) + (0.0003*sind(sa+2*ma))
    j =. j + (0.0004*sind(sa-2*ma)) + (_0.0003*sind(ma+2*sa))
    a =. (0.0028 - 0.0004*cosd(sa)) + 0.0003*cosd(ma)
    if. y=1 do. j =. j+a else. j =. j-a end.
  end.
  j
)

NB. Find time of phases of the moon which surround the given date.
phase_hunt =: 3 : 0
  k1 =. <.((y-35)-2415021.0)%29.53058868 NB. since 1900.1.1 12:00
  p1 =. k1 moon_phase_date 0
  while. 1 do.
    k2 =. k1 + 1
    p2 =. k2 moon_phase_date 0
    if. (p1<:y) *. y<p2 do. break. end.
    p1 =. p2
    k1 =. k2
  end.
  (k1 moon_phase_date"0 i.4),p2
)

NB. ===================================================================

TZ =: 3
ymdhms4kp =: 4 : 'ymdhms4dnf x dnf4jd moon_phase_date/ y' NB. x = TZ

prt4kp =: 4 : 0  NB. x - year y - k,p
  dt =. TZ ymdhms4kp y
  if. x={.dt do. echo (4 2":y),'  ',s4ymdhms dt end.
)

NB. This calculates and prints Moon phases for year Y
print_moon_phases =: 3 : 0
  K0 =. <.12.3685*y-1900
  for_k. K0+i.14 do. for_p. i.4 do. y prt4kp k,p end. end.
)

3 : 0 ARGV_j_ NB. [0] ....j  [1] moonphase.ijs [2...] [year [tz]]
  if. 2>#y do. return. end.
  if. 0='moonphase.ijs'-:_13{.>1{y do. return. end. NB. not called directly
  if. 3<:#y do.
    if. '--help'-:>2{y do.
      echo 'Show Moon phases for current year, or given YEAR (and TIMEZONE)'
      echo 'Args: [YEAR [TIMEZONE]]'
      exit 1
    end.
    if. 4=#y do. TZ =: ".>3{y end.
    echo 'Moon Phases for Year ', (ys=.>2{y), ' and TZ ', ":TZ
    print_moon_phases ".ys
  else.
    p =. s4dnf"0 TZ dnf4jd"0 phase_hunt TZ jd4dnf dnf_now''
    echo 'Last New Moon ', 0{p
    echo 'First Quater  ', 1{p
    echo 'Full Moon     ', 2{p
    echo 'Third Quater  ', 3{p
    echo 'Next New Moon ', 4{p
  end.
  exit 0
)
