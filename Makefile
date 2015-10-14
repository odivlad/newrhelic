PYTHON                 := python
RPMBUILD_SOURCES_PATH  := ~/rpmbuild/SOURCES
SPECFILE               := ./newrhelic.spec
VERFILE                := ./src/_version.py
VERSION                := 0.3.0


all: rpm

clean:
	rm -rvf build dist $(SPECFILE) $(VERFILE)

build: clean prepare
	$(PYTHON) setup.py build

install: build
	$(PYTHON) setup.py install

prepare:
	sed 's/@VERSION@/$(VERSION)/g' $(VERFILE).in > $(VERFILE)
	sed 's/@VERSION@/$(VERSION)/g' $(SPECFILE).in > $(SPECFILE)

dist: clean prepare
	$(PYTHON) setup.py sdist

sources: dist
	cp dist/newrhelic-$(VERSION).tar.gz ~/rpmbuild/SOURCES

srpm: sources
	rpmbuild -bs $(SPECFILE)

rpm: srpm
	rpmbuild -bb $(SPECFILE)
