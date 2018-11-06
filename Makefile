WhatCallThis:
	git clone https://github.com/biodatascience/datasci611.git && \
	git checkout gh-pages && \
	cd data && \
	cd p2_abstracts

fantano.csv:
	git clone https://github.com/justindemonte/DeMonteProject2.git fantano_reviews.csv

install_irr:
	sudo Rscript -e 'install.packages("irr", repos="http://cran.us.r-project.org")' && \
	sudo Rscript -e 'install.packages("reshape", repos="http://cran.us.r-project.org")'

DeMonteProject2Data.R: p4k.csv fantano.csv DeMonteProject2.R install_irr
	Rscript DeMonteProject2.R
	
DeMonteProject2.html: DeMonteProject2.Rmd DeMonteProject2Data.R
	Rscript -e 'rmarkdown::render("DeMonteProject2.Rmd")'

makefile2graph/make2graph: 
	git clone https://github.com/lindenb/makefile2graph.git && \
	cd makefile2graph && \
	make

project2_workflow.png: makefile2graph/make2graph
	make DeMonteProject2.html -Bnd | ./makefile2graph/make2graph | dot -Tpng -o project2_workflow.png	

