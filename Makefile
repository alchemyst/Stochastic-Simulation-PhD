tempfiles = *.aux *.toc *.log *.glo *.gls *.ind *.ilg *.lof *.out \
	*.bbl *.idx *~ *.blg *.lot \#*\# *.nlo *.rel

TARGET = thesis

#Make PDF by default

all: $(TARGET).pdf activity.png

vpath %.fig xfig
vpath %.grp controldiag
vpath %.pdf graph

xfigdir = xfig/
grpdir = controldiag/

xfigfiles = $(wildcard $(xfigdir)/*.fig)
grpfiles = $(wildcard $(grpdir)/*.grp)
graphfiles = $(wildcard $(graphdir)/*.pdf)

thesis.pdf : *.tex $(graphfiles) upthesis.sty
	rubber -d thesis.tex

activity.png: activity.gp activity.dat
	gnuplot activity.gp

activity.dat: activity.db
	sqlite3 -column $< "select date,max(words) from activity group by date;"  > $@

activity.db: *.tex *.sty *.bib
	echo sqlite3 $@ "insert into activity values (date('now'),time('now'),"`detex thesis.tex | wc -w`');'

stats.txt: *.tex *.bib
	./stats > $@

# Phony targets
.PHONY : clean
# The - in the command line causes make to continue in spite of errors
# (like file not found for rm)

clean:
	-rm $(tempfiles)