# colours are background, border, axis, then plotting colors
set terminal png enhanced transparent medium size 481,173 xffffff xd0d0d0 xaaaaaa xffff00
#set terminal png  medium size 481,173 x000000 xd0d0d0 xaaaaaa xffff00
set output 'activity.png'
set style data lines
set style line 1 lw 3
set ylabel 'Words'

set grid
set key outside bottom horizontal reverse Left

set xdata time
set format x '%m-%d'
set timefmt '%Y-%m-%d'
set xrange ["2010-09-25":"2010-12-30"]
#set yrange [0:7000]
# fit trendline
a = 0.05
b = 1284501600 - 946677600 # (date +%s --date="2010-09-15") - (date +%s --date="2000-01-01")
f(x) = a*(x-b)

fit f(x) 'activity.dat' using 1:2 via a, b

plot 'activity.dat' using 1:2 title "detex words", \
     f(x) title sprintf("%.1f words per day", a*24*3600), \
    'targets.dat' using 1:2 title "Carl Masters", \
     'targets.dat' using 1:3 title "Ruanne Masters"
     