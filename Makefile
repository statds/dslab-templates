## define the name of source files as below
rmd_source := template.Rmd

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

$(pdf_out): $(rmd_source) _output.yml $(preamble)
	@make -s check
	@echo "compiling to pdf file..."
	@Rscript --vanilla -e \
	"rmarkdown::render('$(rmd_source)', 'bookdown::pdf_document2')" \


.PHONY: html
html: $(html_out)

$(html_out): $(rmd_source) _output.yml
	@make -s check
	@echo "compiling to html file..."
	@Rscript --vanilla -e \
	"rmarkdown::render('$(rmd_source)', 'bookdown::html_document2')"


.PHONY: check
check:
	@Rscript -e \
	"foo <- 'bookdown' %in% installed.packages()[, 'Package'];" \
	-e "if (! foo) install.packages('bookdown', repos = '$(repos)')" \


.PHONY: clean
clean:
	rm -rf *.aux, *.out *.log *.fls *.fdb_latexmk .Rhistory *\#* .\#* *~

.PHONY: rmCache
rmCache:
	rm -rf *_files *_cache
