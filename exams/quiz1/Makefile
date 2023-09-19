main: \
quiz1.pdf

quiz1.pdf: \
quiz1.tex; pdflatex quiz1

clean:: ; rm -f *~ 
clean:: ; rm -f quiz1.log
clean:: ; rm -f quiz1.aux

cleanall:: clean
cleanall:: ; rm -f quiz1.pdf

