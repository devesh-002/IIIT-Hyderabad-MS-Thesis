latexmk main.tex #&& bash scripts/del.sh
texcount main.tex -inc -incbib -sum -1
