# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         = a4
BUILDDIR      = _build
LANG          = en

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) tmp/$(LANG)
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext

# Taken from zf-framework documentation
pre-build:
	@rm -rf tmp/$(LANG)
	@mkdir -p tmp/$(LANG)
	@cp -R languages/en/* tmp/$(LANG)/
ifneq ($(LANG),en)
	@for f in $$(cd languages/$(LANG) && find . -type f \( ! -iname ".*" \) | sort); do \
		if [ -f languages/en/$$f ]; then \
			if [ $$(stat -c %s languages/$(LANG)/$$f) = $$(stat -c %s languages/en/$$f) ]; then \
				echo "The file '$$f' seems to be exactly the same as English one, perhaps it could be deleted"; \
			fi; \
			cp languages/$(LANG)/$$f tmp/$(LANG)/$$f; \
		else \
			echo "The file '$$f' is not anymore in English directory, check if it's renamed or deleted"; \
		fi; \
	done
endif
	@cp languages/en/conf.py tmp/$(LANG)/conf.py
	@sed -i.bak 's/#language = None/language = "$(LANG)"/' tmp/$(LANG)/conf.py
	@rm -f tmp/$(LANG)/conf.py.bak


help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  dirhtml    to make HTML files named index.html in directories"
	@echo "  singlehtml to make a single large HTML file"
	@echo "  pickle     to make pickle files"
	@echo "  json       to make JSON files"
	@echo "  htmlhelp   to make HTML files and a HTML help project"
	@echo "  qthelp     to make HTML files and a qthelp project"
	@echo "  devhelp    to make HTML files and a Devhelp project"
	@echo "  epub       to make an epub"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  latexpdf   to make LaTeX files and run them through pdflatex"
	@echo "  text       to make text files"
	@echo "  man        to make manual pages"
	@echo "  texinfo    to make Texinfo files"
	@echo "  info       to make Texinfo files and run them through makeinfo"
	@echo "  gettext    to make PO message catalogs"
	@echo "  changes    to make an overview of all changed/added/deprecated items"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"

clean:
	-rm -rf tmp
	-rm -rf $(BUILDDIR)/*

html: pre-build
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html/$(LANG)
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

dirhtml: pre-build
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml/$(LANG)
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

singlehtml: pre-build
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml/$(LANG)
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml."

pickle: pre-build
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle/$(LANG)
	@echo
	@echo "Build finished; now you can process the pickle files."

json: pre-build
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json/$(LANG)
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp: pre-build
	$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $(BUILDDIR)/htmlhelp/$(LANG)
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp."

qthelp: pre-build
	$(SPHINXBUILD) -b qthelp $(ALLSPHINXOPTS) $(BUILDDIR)/qthelp/$(LANG)
	@echo
	@echo "Build finished; now you can run "qcollectiongenerator" with the" \
	      ".qhcp project file in $(BUILDDIR)/qthelp, like this:"
	@echo "# qcollectiongenerator $(BUILDDIR)/qthelp/Tuleap.qhcp"
	@echo "To view the help file:"
	@echo "# assistant -collectionFile $(BUILDDIR)/qthelp/Tuleap.qhc"

devhelp: pre-build
	$(SPHINXBUILD) -b devhelp $(ALLSPHINXOPTS) $(BUILDDIR)/devhelp/$(LANG)
	@echo
	@echo "Build finished."
	@echo "To view the help file:"
	@echo "# mkdir -p $$HOME/.local/share/devhelp/Tuleap"
	@echo "# ln -s $(BUILDDIR)/devhelp $$HOME/.local/share/devhelp/Tuleap"
	@echo "# devhelp"

epub: pre-build
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub/$(LANG)
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."

latex: pre-build
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex/$(LANG)
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex."
	@echo "Run \`make' in that directory to run these through (pdf)latex" \
	      "(use \`make latexpdf' here to do that automatically)."

latexpdf: pre-build
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex/$(LANG)
	@echo "Running LaTeX files through pdflatex..."
	$(MAKE) -C $(BUILDDIR)/latex all-pdf
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex."

text: pre-build
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text/$(LANG)
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text."

man: pre-build
	$(SPHINXBUILD) -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man/$(LANG)
	@echo
	@echo "Build finished. The manual pages are in $(BUILDDIR)/man."

texinfo: pre-build
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo/$(LANG)
	@echo
	@echo "Build finished. The Texinfo files are in $(BUILDDIR)/texinfo."
	@echo "Run \`make' in that directory to run these through makeinfo" \
	      "(use \`make info' here to do that automatically)."

info: pre-build
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo/$(LANG)
	@echo "Running Texinfo files through makeinfo..."
	make -C $(BUILDDIR)/texinfo info
	@echo "makeinfo finished; the Info files are in $(BUILDDIR)/texinfo."

gettext: pre-build
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) $(BUILDDIR)/locale/$(LANG)
	@echo
	@echo "Build finished. The message catalogs are in $(BUILDDIR)/locale."

changes: pre-build
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes/$(LANG)
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

linkcheck: pre-build
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck/$(LANG)
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

doctest: pre-build
	$(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest/$(LANG)
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."