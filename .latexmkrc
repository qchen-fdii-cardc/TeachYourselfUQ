$pdf_mode = 5;

# Put all generated files in build/
$out_dir = 'build';
$aux_dir = 'build';

# Default targets: compile all .tex files in writings/
@default_files = glob('writings/*.tex');

# Always compile with xelatex
$xelatex = 'xelatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

# Use wslview for PDF preview in WSL
$pdf_previewer = 'wslview %S';

$force_mode = 1; # -f