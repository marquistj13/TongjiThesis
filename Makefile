# Makefile for ThuThesis

# Compiling method: latexmk/xelatex/pdflatex
METHOD = latexmk
# Set opts for latexmk if you use it
LATEXMKOPTS = -xelatex -halt-on-error -interaction=nonstopmode
# Basename of thesis
THESISMAIN = thesis
# Basename of shuji
SHUJIMAIN = shuji

PACKAGE=tongjithesis
SOURCES=$(PACKAGE).ins $(PACKAGE).dtx
THESISCONTENTS=$(THESISMAIN).tex data/*.tex $(FIGURES)
# NOTE: update this to reflect your local file types.
FIGURES=$(wildcard figures/*.eps figures/*.pdf)
BIBFILE=ref/*.bib
BSTFILE=*.bst
SHUJICONTENTS=$(SHUJIMAIN).tex
CLSFILES=$(PACKAGE).cls $(PACKAGE).cfg

# make deletion work on Windows
ifdef SystemRoot
	RM = del /Q
	OPEN = start
else
	RM = rm -f
	OPEN = open
endif

.PHONY: all clean distclean dist thesis viewthesis shuji viewshuji doc viewdoc cls 

all: thesis shuji

cls: $(CLSFILES)

viewthesis: thesis
	$(OPEN) $(THESISMAIN).pdf

thesis: $(THESISMAIN).pdf

viewshuji: shuji
	$(OPEN) $(SHUJIMAIN).pdf

shuji: $(SHUJIMAIN).pdf

ifeq ($(METHOD),latexmk)

$(THESISMAIN).pdf:  $(BSTFILE) $(CLSFILES)
	$(METHOD) $(LATEXMKOPTS) $(THESISMAIN)

$(SHUJIMAIN).pdf: $(CLSFILES) 
	$(METHOD) $(LATEXMKOPTS) $(SHUJIMAIN)

else ifneq (,$(filter $(METHOD),xelatex pdflatex))

$(THESISMAIN).pdf: $(CLSFILES) $(THESISCONTENTS) $(THESISMAIN).bbl
	$(METHOD) $(THESISMAIN)
	$(METHOD) $(THESISMAIN)

$(THESISMAIN).bbl: $(BIBFILE) $(BSTFILE)
	$(METHOD) $(THESISMAIN)
	-bibtex $(THESISMAIN)
	$(RM) $(THESISMAIN).pdf

$(SHUJIMAIN).pdf: $(CLSFILES) $(SHUJICONTENTS)
	$(METHOD) $(SHUJIMAIN)

else
$(error Unknown METHOD: $(METHOD))

endif

clean:
	latexmk -c  $(THESISMAIN) $(SHUJIMAIN)
	-@$(RM) *~ $(THESISMAIN).xdv $(SHUJIMAIN).xdv

cleanall: clean
	-@$(RM)  $(THESISMAIN).pdf $(SHUJIMAIN).pdf

distclean: cleanall
	-@$(RM) -r dist

dist: all
	@if [ -z "$(version)" ]; then \
		echo "Usage: make dist version=[x.y.z | ctan]"; \
	else \
		npm run build -- --version=$(version); \
	fi
