#!/usr/bin/env perl
$latex         = 'platex -kanji=sjis -synctex=1 -halt-on-error -file-line-error';
$latex_silent  = 'platex -kanji=sjis -synctex=1 -halt-on-error -interaction=batchmode -file-line-error';
#$latex         = 'platex -synctex=1 -halt-on-error -file-line-error';
#$latex_silent  = 'platex -synctex=1 -halt-on-error -interaction=batchmode -file-line-error';
$bibtex        = 'pbibtex';
$dvipdf        = 'dvipdfmx %O -o %D %S';
$makeindex     = 'mendex %O -o %D %S';
$max_repeat    = 5;
$pdf_mode      = 3;
$pvc_view_file_via_temporary = 0;
$pdf_previewer    = "open -ga /Applications/Skim.app";
