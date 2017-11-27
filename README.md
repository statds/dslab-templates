Data Science Lab Project Templates
==============================

The repository provides R Markdown templates for data science lab projects.


## Getting Started

We may download and unpack the [ZIP][zip] file of the repository, then compile
the source document within [RStudio][rstudio] (by clicking the button *knit* or
hitting the shortcut *Ctrl+Shift+K*).

Alternatively (and probably more efficiently), we may clone the repository and
let the Makefile help reproduce the output as follows:

```bash
git clone https://github.com/statds/dslab-templates.git
cd dslab-templates
make       # for output in pdf and html
```

The available targets in the Makefile include

- `all`, default target for output in PDF and HTML.
- `pdf` for PDF output only
- `html`  for HTML output only
- `clean` for cleaning some temporary files such as `*.log` and `*.aux`.
- `rmCache` for cleaning cache files, which can be crucial if we modified
    code chunk for a new evaluation.


## Output Preview

The output of the templates in PDF and HTML are available for preview.

- [PDF](https://statds.github.io/dslab-templates/template.pdf)
- [HTML](https://statds.github.io/dslab-templates/)



[zip]: https://github.com/statds/dslab-templates/archive/master.zip
[rstudio]: https://www.rstudio.com/
