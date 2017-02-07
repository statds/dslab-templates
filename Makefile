## define the name of source files as below
rmd_source := template.Rmd

## preamble in .tex under directory latex
preamble := $(wildcard latex/*.tex)

## set output directory for ease of publish
outdir := docs

## corresponding output names
pdf_name := $(patsubst %.Rmd,%.pdf,$(rmd_source))
html_name := $(patsubst %.Rmd,%.html,$(rmd_source))
pdf_out := $(patsubst %.Rmd,$(outdir)/%.pdf,$(rmd_source))
html_out := $(patsubst %.Rmd,$(outdir)/%.html,$(rmd_source))

## CRAN mirror
repos := https://cloud.r-project.org


.PHONY: all
all: $(pdf_out) $(html_out)

.PHONY: pdf
pdf: $(pdf_out)

$(pdf_out): $(rmd_source) _output.yml $(preamble) | $(outdir)
	@make -s check
	@echo "compiling to pdf file..."
	@Rscript -e \
	"rmarkdown::render('$(rmd_source)', 'bookdown::pdf_document2')" \
	--vanilla
	@mv $(pdf_name) $(outdir)

.PHONY: html
html: $(html_out)

$(html_out): $(rmd_source) _output.yml | $(outdir)
	@make -s check
	@echo "compiling to html file..."
	@Rscript -e \
	"rmarkdown::render('$(rmd_source)', 'bookdown::html_document2')" \
	--vanilla
	@mv $(html_name) $(outdir)

.PHONY: check
check:
	@Rscript -e \
	"foo <- 'bookdown' %in% installed.packages()[, 'Package'];" \
	-e "if (! foo) install.packages('bookdown', repos = '$(repos)')" \
	--vanilla

$(outdir):
	@mkdir -p $(outdir)
	@echo "Directory $(outdir) created."

.PHONY: clean
clean:
	rm -rf *.aux, *.out *.log *.fls *.fdb_latexmk .Rhistory *\#* .\#* *~

.PHONY: rmCache
rmCache:
	rm -rf *_files *_cache
