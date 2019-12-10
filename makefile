.PHONY = all clean

all: src/count_words.tex src/count_chars.txt thesis.pdf index.html readme.md

src/count_words.tex: src/thesis.tex
	cd src && detex thesis.tex | wc -w >  count_words.txt

src/count_chars.tex: src/thesis.tex
	cd src && detex thesis.tex | wc -m >> count_chars.txt

thesis.pdf: src/thesis.tex count_words.txt count_chars.txt
	cd src && pdflatex -interaction=nonstopmode thesis.tex
	cd src && bibtex thesis.aux
	cd src && pdflatex -interaction=nonstopmode thesis.tex
	cd src && pdflatex -interaction=nonstopmode thesis.tex
	mv src/thesis.pdf thesis.pdf

index.html: src/thesis.tex
	cd src && make4ht thesis.tex "style, charset=utf-8" " -cunihtf -utf8" "" " -interaction=nonstopmode"
	mv src/thesis.html index.html
	mv src/thesis.css thesis.css

readme.md: src/thesis.tex
	cd src && pandoc -t markdown_strict -s --bibliography=bibliography.bib --toc thesis.tex -o readme.md
	cat src/info.md src/readme.md > readme.md

clean:
	#rm thesis.4ct thesis.4tc thesis.aux thesis.bbl thesis.blg thesis.dvi thesis.idv thesis.lg thesis.log thesis.out thesis.tmp thesis.toc thesis.xref thesis*.png
	#rm src/thesis.4ct src/thesis.4tc src/thesis.aux src/thesis.bbl src/thesis.blg src/thesis.dvi src/thesis.idv src/thesis.lg src/thesis.log src/thesis.out src/thesis.tmp src/thesis.toc src/thesis.xref src/thesis*.png