NB. Date in TJD format: TJD = MJD-40000 = JD-2440000.5
NB. http://www.csgnetwork.com/juliantruncdateconv.html
NB. http://en.wikipedia.org/wiki/Julian_day
NB. Unix range dates are uint16: 1970/1/1..2038/1/18 --> 587..25441
NB. All dates before 10/15/1582 are Julian! All after are Gregorian.
NB. There were no dates 10/5..10/14! After 10/4/1582 there was 10/15/1582.
NB. TJD time is "naive" or local. To convert it to JDN, a time zone must
NB. be specified. JDN and Unix time are absolute (moments in real time).
NB. DN - day number = TJD w/o fraction. DF - day fraction. DNF - both.
NB. Copyright (C) Georgiy Pruss 2013-2015

TJD =: 0 : 0
   * conversions
   dn4ymd y m d -> dn, y can be 0 _1 _2 etc, m and d <1, >12 and 31
   ymd4dn dn -> y m d
   wd4dn dn -> wd, weekday, 0..6 for Sun to Sat
   wd_4dn dn -> wd, weekday, 1..7 for Mon to Sun
   df4hms h m s -> df, fraction of day
   hms4df df -> h m s (to get days, split first into int. and fraction)
   dnf4ymdhms y m d h m s -> dnf
   ymdhms4dnf dnf -> y m d h m s
   * current moment
   ymd_now'' -> y m d, current local date
   hms_now'' -> h m s, current local time (use 6!:0'' for ymdhms)
   dn_now'' -> dn, current local dn
   dnf_now'' -> dnf, current local dnf
   * formatting
   s4hms h m s -> 'HH:MM:SS'
   s4ymd y m d -> 'YYYY.MM.DD'
   s4ymdhms y m d h m s -> 'YYYY.MM.DD HH:MM:SS'
   s4dnf dnf -> 'YYYY.MM.DD HH:MM:SS'
   * julian day - it is absolute, so it needs tz in addition to dnf
tz dnf4jd jd -> dnf, dnf for given timezone and julian day
tz jd4dnf dnf -> jd, julian day considering timezone of dnf
tz jd_now'' -> jd, considering current (given) timezone
tz s4jd jd -> 'YYYY.MM.DD HH:MM:SS'
   moonphase4jd jd -> float, moon phase day, 0..29.5+-0.3, max +-0.6
   mpx'' -> prints some moon phase data, experimental; see 'moon.ijs'
   * unix time - it just relates to jd
   ut4jd jd -> ut, unix time from julian day
   jd4ut ut -> jd, julian day from unix time
   * timezone
   getTimeZoneInfo'' -> daylightsaving;offsetminutes;windowstzinfo
   getTZ tzinfo -> tz, get tz offset in hours from tzinfo (fn. above)
   TZINFO, TZ - values, set during initialization of the package
   * tests, etc
   is_leap_year y -> bool, uses Julian calendar before year 1582
   is_valid_ymd y m d -> bool, checks correctness of y m d
   is_ut_dn dn -> bool, tjd is between 1970.1.1 and 2038.1.18
   is_ut_year y -> bool, y is between 1970 and 2038
m  days_in_month y -> int, number of days in month m, year y
n wd nth_day_of_month y m -> dn, n-th (0=last) weekday wd in month m, year y
   ensure_workday dn -> dn, advances from Sat,Sun to Mon
   * data types of arguments above
   dn  - day number, TJD, 1970.1.1 = 587
   dnf - TJD+fraction (like dn, it is relative/local time)
   jd  - julian day, dn+2440000.5, _4712.1.1 noon = 0, 2000.1.1 noon = 2451545.0
   ut  - unix time, 1970.1.1 00:00:00 = 0 (like jd, it is absolute time)
   tz  - time zone offset in hours (positive for East, negative for West)
)

DNMIN =: 587   NB. For unix time, may be used to check date (1970.1.1)
DNMAX =: 25441 NB. For unix time, may be used to check date (2038.1.18)
DNMOON =: 29.53058867 NB. lunar synodic month

MDAYS =: 0 31 28  31 30 31  30 31 31  30 31 30  31

NB. Checks if date (in TJD) is between 1970.1.1 and 2038.1.18
is_ut_dn =: 3 : '(DNMIN <: y) *. y <: DNMAX'

NB. Checks if year is between 1970 and 2038
is_ut_year =: 3 : '(1970 <: y) *. y <: 2038'

NB. Checks if y is a leap year. Before 1582 Julian calendar is used! TODO neg
is_leap_year =: 3 : 'if. y<1582 do. 0=4|y else. (0=400|y)+.(0~:100|y)*.0=4|y end.'

NB. Return number of days in month x of year y
days_in_month =: 4 : 'if. (is_leap_year y) *. x=2 do. 29 else. x{MDAYS end.'

NB. Checks if there exist such a day
NB. Note. dn4ymd accepts any m and d!
is_valid_ymd =: 3 : 0 NB. y m d
  'y m d' =. y
  if. (d<1)+.(m<1)+.m>12 do. 0 return. end.
  if. y=1582 do.
    if. (5<:d)*.(d<:14)*.m=10 do. 0 return. end. NB. no dates 10/5..10/14!
  end.
  if. d<:m{MDAYS do. 1 return. end.
  if. d>29 do. 0 return. end.
  is_leap_year y
)

NB. Convert date to TJD number. Month and day may be quite wild.
NB. Years are mathematical! ... _3 _2 _1 0 1 2 3 ... TODO FIX!
dn4ymd =: 3 : 0
  'year month day' =. y
  NB. Years BC: 0 = 1 BC, -1 = 2 BC, -2 = 3 BC, etc
  b =. 0
  if. month > 12 do.
    year =. year + <.month%12
    month =. 12|month
  elseif. month < 1 do.
    month =. -month
    year =. year - >:<.month%12
    month =. 12 - 12|month
  end.
  if. month < 3 do.
    year =. year - 1
    month =. month + 12
  end.
  if. 15821014 < (year*10000) + (month*100) + day do.
    b =. 2 - (<.year%100) - <.year%400
  end.
  _719006 + (<.4%~1461*year) + (<.30.6001*>:month) + day + b
)

NB. Convert TJD day number to tuple year month day
ymd4dn =: 3 : 0
  jdi =. y + 2440000
  if. jdi < 2299160 do. NB. (1582, 10, 15)
    b =. jdi + 1525
  else.
    alpha =. <. (_7468861 + 4*jdi)%146097
    b =. jdi + 1526 + alpha - <.alpha%4
  end.
  c =. <.(_2442 + 20*b)%7305
  d =. <.(1461*c)%4
  e =. <.(b - d)%30.6001
  day =. (b - d) - <.30.6001*e
  if. e < 14 do. month =. e - 1 else. month =. e - 13 end.
  if. month > 2 do. year =. c - 4716 else. year =. c - 4715 end.
  year,month,day
)

NB. Convert date day number to weekday 0..6 (Sun..Sat) or 1..7 (Mon..Sun)
wd4dn =: 7|5+]
wd_4dn =: 1+7|4+]

NB. Return day fraction for h,m,s: h/24 + m/24*60 + s/24*3600
df4hms =: +/ @: %&24 1440 86400

NB. Return h,m,s for day fraction 0<=d<1"
hms4df =: 3 : 0
  y =. y - h =. <.y =. y * 24
  y =. y - m =. <.y =. y * 60
  h,m,y*60
)

NB. Return day number with fraction for full local date y m d h m s
dnf4ymdhms =: 3 : '(dn4ymd 3{.y)+df4hms 3}.y'

NB. Return y m d h m s for day number with fraction
ymdhms4dnf =: 3 : '(ymd4dn d),hms4df y-d=.<.y'

NB. Return Julian Day Number -- JDN 0.0 is noon GMT Mon 1/1 4713 BC Julian
NB. Adjust it for the time zone tz (in hours) -- left argument,
NB. e.g. PST = _8, PDT = _7, EST = _5, EDT = _4, EET = 2, EEST = 3, etc.
jd4dnf =: 4 : 'y+2440000.5-x%24.0'

NB. Return dnf from Julian Day Number and convert to given tz
dnf4jd =: 4 : 'y-2440000.5-x%24.0'

NB. Return approx moon phase, in days. Error is +-0.3 day, max +-0.6 day.
moonphase4jd =: 3 : 'DNMOON|y-2449128.59'

0 : 0
  delta_t = sdate - 2415021.0 # JDN for (1900,1,1,12:00)
  t = delta_t / 36525.0
  t2 = t * t; t3 = t2 * t
  p = 2415020.75933 + c.synodic_month*k + 0.0001178*t2 - 0.000000155*t3
  return p + 0.00033*dsin(166.56 + 132.87*t - 0.009173*t2)
)

NB. Return current ymd, hms, day number, day number with fraction
ymd_now =: 3 : '3{.6!:0'''''    NB. ymdhms_now is just 6!:0''
hms_now =: 3 : '3}.6!:0'''''    NB. e.g. run s4ymdhms 6!:0''
dn_now  =: 3 : 'dn4ymd 3{.6!:0'''''
dnf_now =: 3 : '(dn4ymd 3{.t) + df4hms 3}.t=.6!:0'''''
jd_now =: 4 : 'x jd4dnf dnf_now''''' NB. left argument - TIME ZONE!

NB. Format date/time with leading zeros for all but YEAR.
s4hms =: [:}.[:,'r<:0>3.0'8!:2]                 NB. HH:MM:SS
s4ymd =: 3 : '(":{.y),,''r<.0>3.0''8!:2}.y'     NB. YEAR.MM.DD
s4ymdhms =: 3 : '(s4ymd 3{.y),'' '',s4hms 3}.y' NB. YEAR.MM.DD HH:MM:SS
s4dnf =: 3 : 's4ymdhms ymdhms4dnf y'
s4jd =: 4 : 's4dnf x dnf4jd y'                  NB. x = TIME ZONE!

NB. Conversion to Unix time and back
ut4jd =: *&86400 @ -&2440587.5
jd4ut =: +&2440587.5 @ %&86400

NB. Return DN corresponding to Monday if argument is Saturday or Sunday
ensure_workday =: 3 : 'y++/1 2*0 6=wd4dn y'

NB. Return n-th weekday in given month (as dn). Zero for the last day.
NB. E.g. 1st Sunday in April 2011 is April 3 (1,0,4,2011 --> 2011.4.3)
NB. Last Friday in 2011 is on December 30 (0,5,12,2011 --> 2011.12.30)
nth_day_of_month =: 4 : 0 NB. x-->n w  y-->year month
  'n w'=.x
  dn =. dn4ymd y,1
  wd =. wd4dn dn
  d =. >:w-wd
  if. d<1 do. d =. d+7 end.
  dn =. dn+d-1
  if. n>0 do.
    dn =. dn+(n-1)*7
  else. NB. n=0
    ymd =. ymd4dn dn =. dn+28
    if. (1{y)~:1{ymd do. dn =. dn-7 end.
  end.
  dn
)

NB. some try at Moon data
mpx =: 3 : 0
  j =. 3 jd4dnf dnf_now ''
  mp =. moonphase4jd j
  np =. DNMOON-mp
  mph =. nph =. ''
  if. mp<1 do. mph =. '/',(0j1":mp*24),'h' end.
  if. np<1 do. nph =. '/',(0j1":np*24),'h' end.
  echo (0j1":mp*100%DNMOON),'% ',(0j2":mp),mph,' (',(0j2":np),nph,')'
)

NB.From types/datetime/datetime.ijs
NB.*getTimeZoneInfo v function to return Windows time zone info
NB.-eg: getTimeZoneInfo ''
NB.-result: 3-item list of boxed info:
NB.-   0{:: Daylight saving status (0 unknown, 1 standarddate, 2 daylightdate)
NB.-   1{:: Bias (offset of local zone from UTC in minutes)
NB.-   2{:: 2 by 3 boxed table: Standard,Daylight by Name,StartDate,Bias
getTimeZoneInfo =: 3 : 0
  'tzstatus tzinfo'=. 'kernel32 GetTimeZoneInformation i *i'&cd <(,43#0)
  NB. read TIME_ZONE_INFORMATION structure
  tzinfo=. (1 (<:+/\ 1 16 4 1 16 4 1)}43#0) <;.2 tzinfo    NB. 4 byte J integers
  tzbias=. 0{:: tzinfo
  tzinfo=. _3]\ }. tzinfo                  NB. Standard info ,: Daylight info
  'name date bias'=. i. 3                  NB. column labels for tzinfo
  tmp=. (6&u:)@(2&ic)&.> name {"1 tzinfo   NB. read names as unicode text
  tmp=. (0{a.)&taketo&.> tmp               NB. take to first NUL
  tzinfo=. tmp (<a:;name)}tzinfo           NB. amend TZ names
  tmp=. _1&ic@(2&ic)&.> date{"1 tzinfo     NB. read SYSTEMTIME structures
  tzinfo=. tmp (<a:;date)}tzinfo           NB. amend TZ dates

  tzstatus;tzbias;<tzinfo
)
NB.+-+----+----------------------------------------+
NB.|2|_120|+-----------------+----------------+---+|
NB.| |    ||FLE Standard Time|0 10 0 5 4 0 0 0|0  ||
NB.| |    |+-----------------+----------------+---+|
NB.| |    ||FLE Daylight Time|0 3 0 5 3 0 0 0 |_60||
NB.| |    |+-----------------+----------------+---+|
NB.+-+----+----------------------------------------+

getTZ =: 3 : 0 NB. get TZ in hours suitable for tjd fns
  'tzstatus tzbias tzinfo'=.y
  if. tzstatus=0 do. 0 else. - (tzbias + 2{::(tzstatus=2){tzinfo) % 60 end.
)

TZ =: getTZ TZINFO =: getTimeZoneInfo''
