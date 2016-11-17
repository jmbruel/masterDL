#-----------------------------------------------------
DZSLIDES=../asciidoctor-backends/slim/dzslides
STYLE=../asciidoctor-stylesheet-factory/stylesheets/jmb.css
#ASCIIDOCTOR=asciidoctor  -a icons=font -a linkcss! -a data-uri
ASCIIDOCTOR=asciidoctor -a icons=font
EXT=adoc
OUTPUT=.
SITE=../jmbruel.github.io/teaching
#THEME=colony
THEME=riak
#The valid options are coderay, highlightjs, prettify, and pygments.
HIGHLIGHT=pygments
MAIN=TD1
DEP= organisation.adoc introduction.adoc glossaire.adoc exigences.adoc SysML.adoc
#-----------------------------------------------------

all: $(OUTPUT)/$(MAIN).html $(OUTPUT)/$(MAIN).dzslides.html $(OUTPUT)/$(MAIN).teacher.html

$(OUTPUT)/%.html: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files to generate HTML'
	$(ASCIIDOCTOR) -b html5 \
		-a numbered \
		-a toc2 \
		-r asciidoctor-diagram \
		-a source-highlighter=$(HIGHLIGHT) \
		-o $@ $<

$(OUTPUT)/%.dzslides.html: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files to generate Dzslides'
	$(ASCIIDOCTOR) -b dzslides \
		-T $(DZSLIDES) -E slim \
		-a slides -a dzslides \
		-a correction \
		-a styledir=. \
		-a stylesheet=$(STYLE) \
		-r asciidoctor-diagram \
		-a source-highlighter=$(HIGHLIGHT) \
		-o $@ $<

$(OUTPUT)/%.teacher.html: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files to generate HTML'
	$(ASCIIDOCTOR) -b html5 \
		-a prof \
		-a numbered \
		-a toc2 \
		-r asciidoctor-diagram \
		-a source-highlighter=$(HIGHLIGHT) \
		-o $@ $<

$(OUTPUT)/%.sujet.html: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files to generate subject for student'
	$(ASCIIDOCTOR) -b html5 \
		-a numbered \
		-r asciidoctor-diagram \
		-a source-highlighter=$(HIGHLIGHT) \
		-o $@ $<

$(OUTPUT)/%.pdf: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files to generate PDF'
	$(ASCIIDOCTOR) -b html5 \
		-b pdf \
		-r asciidoctor-pdf \
		-a source-highlighter=$(HIGHLIGHT) \
		-a book \
		-o $@ $<

deploy:
	cp $(MAIN).html $(SITE)/MobileModeling.html
	cd $(SITE)

clean:
	rm *.cache
	rm images/*.cache
