PDF := talk.pdf
TEX := talk.tex
PLOTS :=

.PHONY: all clean distclean

all: $(PDF)

$(PDF):
	latexmk -pdf $<

clean:
	rm -f *~ *.bak *.aux *.log *.toc *.bbl *.blg *.nav *.out *.snm *.backup
	rm -f plots/*.aux plots/*.log
	rm -f $(PLOTS)

distclean: clean
	rm -f $(PDF)
