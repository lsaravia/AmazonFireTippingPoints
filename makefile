OPTS= -H margins.sty --bibliography GlobalFireTippingPoints.bib --citeproc --csl=proceedings-of-the-royal-society-b.csl --pdf-engine=xelatex 
all: AmazonasFires.pdf Appendices.pdf


%.pdf:%.md
	pandoc $< -o $@ 
	evince $@		

AmazonasFires.pdf: AmazonasFires.md margins.sty makefile
	pandoc $< -o $@ $(OPTS)
		

FiguresTables.pdf: FiguresTables.md AmazonasFires.md margins.sty 
	pandoc $< -o $@ 
	evince $@		

Appendices.pdf: Appendices.md 
	pandoc -H Appendices.sty --bibliography GlobalFireTippingPoints.bib --citeproc --csl=proceedings-of-the-royal-society-b.csl $^ -o $@
	evince $@		

AmazonasFires.docx: AmazonasFires.md makefile
	pandoc $< -o $@ $(OPTS)
			
AmazonasFires_bioRxiv.pdf: AmazonasFires.md nolineno.sty 
	pandoc $< -o $@ -H nolineno.sty --bibliography GlobalFireTippingPoints.bib --pdf-engine=xelatex --citeproc --csl=proceedings-of-the-royal-society-b.csl		
