#!/bin/bash


TARGET=main
COMPILER=pdflatex


function CheckError
{
   "$@"

   ErrorCode=$?

   if [ $ErrorCode != 0 ]; then
      echo -e "\n\n******************************************************************"
      echo -e "$@ failed ... (error code = $ErrorCode)"
      echo -e "******************************************************************\n\n"
      exit 1
   else
      echo -e "\n\n******************************************************************"
      echo -e "$@ passed"
      echo -e "******************************************************************\n\n"
   fi
}


rm -f $TARGET.dvi $TARGET.aux $TARGET.log $TARGET.blg $TARGET.pdf ${TARGET}Notes.bib

 CheckError $COMPILER  $TARGET.tex
 CheckError bibtex     $TARGET.aux
 CheckError $COMPILER  $TARGET.tex
 CheckError $COMPILER  $TARGET.tex
 CheckError $COMPILER  $TARGET.tex

 if [ $COMPILER = "latex" ]; then
 CheckError dvipdf     $TARGET.dvi
 fi

rm -f $TARGET.dvi $TARGET.aux $TARGET.log $TARGET.blg $TARGET.out ${TARGET}Notes.bib
