OPTS= -H margins.sty --bibliography GlobalFireTippingPoints.bib --citeproc --csl=oikos.csl --pdf-engine=xelatex 

all: AmazonasFires.pdf Appendices.pdf AmazonasFires_preprint.pdf AmazonasFiresTitle.pdf AmazonasFiresMain.pdf AmazonasFiresMainSubmited4.tex AmazonasFiresMain.tex
 

%.pdf:%.md
	pandoc $< -o $@ $(OPTS)
	open $@		

AmazonasFires.pdf: AmazonasFires.md margins.sty 
	pandoc $< -o $@ $(OPTS)
		
Appendices.pdf: Appendices.md 
	pandoc -H Appendices.sty --bibliography GlobalFireTippingPoints.bib --citeproc --csl=oikos.csl $^ -o $@
	open $@		

AmazonasFires.docx: AmazonasFires.md makefile
	pandoc $< -o $@ $(OPTS)
			
AmazonasFires_preprint.pdf: AmazonasFires.md nolineno.sty 
	pandoc $< -o $@ -H nolineno.sty --bibliography GlobalFireTippingPoints.bib --pdf-engine=xelatex --citeproc --csl=oikos.csl		


%.tex:%.md
	pandoc $< -o $@ $(OPTS)