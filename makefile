.PHONY = all clean

all: 8-count.tex thesis.pdf thesis.html readme.md

8-count.tex: thesis.tex
	chars=$(detex thesis.tex | wc -m)
	words=$(detex thesis.tex | wc -w)
	printf "\n\n\\\emph{${chars} characters, ${words} words}" > 8-count.tex

thesis.pdf: thesis.tex 8-count.tex
	pdflatex -interaction=nonstopmode thesis.tex
	bibtex thesis.aux
	pdflatex -interaction=nonstopmode thesis.tex
	pdflatex -interaction=nonstopmode thesis.tex

thesis.html: thesis.tex
	make4ht thesis.tex "style, charset=utf-8" " -cunihtf -utf8" "" " -interaction=nonstopmode"

readme.md: thesis.tex
	pandoc -t markdown_strict -s --bibliography=bibliography.bib --toc thesis.tex -o readme.md

clean:
	rm thesis.4ct thesis.4tc thesis.bbl thesis.blg thesis.dvi thesis.idv thesis.lg thesis.log thesis.tmp thesis.toc thesis.xref thesis*.png