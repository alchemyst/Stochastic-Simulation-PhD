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

thesis.pdf: *.tex $(graphfiles) upthesis.sty thesis.bib
	rubber -d thesis.tex

# regularise the references from zotero database
thesis.bib: zotero_export.bib
	bibtool -f "%-n(author)%4d(year)%-T(title)" $< -o $@

activity.png: activity.gp activity.dat
	gnuplot activity.gp

activity.dat: activity.db
	sqlite3 -column $< "select date(timestamp) as date,max(words) from activity group by date;"  > $@

activity.db: *.tex *.sty *.bib
	./activity $@

stats.txt: *.tex *.bib
	./stats > $@

# Phony targets
.PHONY : clean

# The - in the command line causes make to continue in spite of errors
# (like file not found for rm)
clean:
	-rm $(tempfiles)
