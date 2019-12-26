.PHONY = all count pdf html md clean

all: count pdf html md

count: thesis.tex
	detex thesis.tex | wc -w >  count_words.tex
	detex thesis.tex | wc -m > count_chars.tex

pdf: thesis.tex count
	pdflatex -interaction=nonstopmode thesis.tex
	bibtex thesis.aux
	pdflatex -interaction=nonstopmode thesis.tex
	pdflatex -interaction=nonstopmode thesis.tex

html: thesis.tex count
	make4ht thesis.tex "style, charset=utf-8" " -cunihtf -utf8" "" " -interaction=nonstopmode"
	mv thesis.html index.html

md: thesis.tex count
	pandoc -t markdown_strict -s --bibliography=bibliography.bib --toc thesis.tex -o thesis.md
	cat info.md thesis.md > readme.md

clean:
	rm thesis.4ct thesis.4tc thesis.aux thesis.bbl thesis.blg thesis.dvi thesis.idv thesis.lg thesis.log thesis.out thesis.tmp thesis.toc thesis.xref thesis*.png