#!/usr/bin/env bash
chars=$(detex thesis.tex | wc -m)
words=$(detex thesis.tex | wc -w)
printf "\n\n\\\emph{${chars} characters, ${words} words}" > 8-count.tex
latex thesis.tex
bibtex thesis.aux
latex thesis.tex
latex thesis.tex