find . -maxdepth 1 -type f -name "main.*" ! -name "main.tex" ! -name "main.pdf" -exec rm -v {} \;

