.PHONY = all pdf html md clean

# apt install texlive texlive-latex-extra texlive-bibtex-extra

all: pdf clean

pdf: thesis.tex
	pdflatex -interaction=nonstopmode thesis.tex
	bibtex thesis.aux
	pdflatex -interaction=nonstopmode thesis.tex
	pdflatex -interaction=nonstopmode thesis.tex
	mv thesis.pdf ../thesis.pdf

html: thesis.tex
	make4ht thesis.tex "style, charset=utf-8" " -cunihtf -utf8" "" " -interaction=nonstopmode"
	mv thesis.html index.html

md: thesis.tex
	pandoc -t markdown_strict -s --bibliography=bibliography.bib --toc thesis.tex -o thesis.md
	cat info.md thesis.md > readme.md`

clean:
	rm *.log *.aux *.bbl *.blg *.out *.toc