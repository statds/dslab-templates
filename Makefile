## define the name of source files as below
rmd_source := $(wildcard *.Rmd)

## preamble in .tex under directory latex
preamble := $(wildcard latex/*.tex)

## corresponding output names
pdf_out := $(patsubst %.Rmd,%.pdf,$(rmd_source))
html_out := $(patsubst %.Rmd,%.html,$(rmd_source))

## CRAN mirror
repos := https://cloud.r-project.org


.PHONY: all
all: $(pdf_out) $(html_out)

.PHONY: pdf
pdf: $(pdf_out)

%.pdf: %.Rmd _output.yml $(preamble)
	@$(MAKE) -s check
	@echo "compiling to pdf file..."
	@Rscript --vanilla -e \
	"rmarkdown::render('$<', 'bookdown::pdf_document2')" \


.PHONY: html
html: $(html_out)

%.html: %.Rmd _output.yml
	@$(MAKE) -s check
	@echo "compiling to html file..."
	@Rscript --vanilla -e \
	"rmarkdown::render('$<', 'bookdown::html_document2')"


.PHONY: check
check:
	@Rscript -e \
	"foo <- 'bookdown' %in% installed.packages()[, 'Package'];" \
	-e "if (! foo) install.packages('bookdown', repos = '$(repos)')" \


.PHONY: clean
clean:
	@rm -rf *.aux *.bbl *.blg *.fls *.fdb_latexmk\
		*.log *.out .Rhistory *\#* .\#* *~

.PHONY: rmCache
rmCache:
	rm -rf *_files *_cache
