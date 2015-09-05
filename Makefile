# webtrees: online genealogy
# Copyright (C) 2015 webtrees development team
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

LANGUAGE_DIR=src/modulename/language
LANGUAGE_SRC=$(shell git grep -I --name-only --fixed-strings -e I18N:: -- "*.php" "*.xml")
MO_FILES=$(patsubst %.po,%.mo,$(PO_FILES))
PO_FILES=$(wildcard $(LANGUAGE_DIR)/*.po)
SHELL=bash

.PHONY: clean update vendor

################################################################################
# Update 
################################################################################
update: $(MO_FILES) src/modulename/language/_default.pot

vendor:
	composer.phar self-update
	composer.phar update
	composer.phar dump-autoload --optimize


################################################################################
# Remove temporary and intermediate files
################################################################################
clean:
	rm -Rf src/modulename/language/webtrees.pot
	find src/modulename/language -name "*.mo" -not -path "language/en_US.mo" -delete

################################################################################
# Gettext template (.POT) file
################################################################################
src/modulename/language/_default.pot: $(LANGUAGE_SRC)
	# Modify the .XML report files so that xgettext can scan them
	echo $^ | xargs xgettext --package-name=webtrees --package-version=1.0 --msgid-bugs-address=i18n@webtrees.net --output=$@ --no-wrap --language=PHP --add-comments=I18N --from-code=utf-8 --keyword --keyword=translate:1 --keyword=translateContext:1c,2 --keyword=plural:1,2 --keyword=noop:1

################################################################################
# Gettext catalog (.PO) files
################################################################################
$(PO_FILES): src/modulename/language/_default.pot
	msgmerge --no-wrap --sort-output --no-fuzzy-matching --output=$@ $@ $<

################################################################################
# Gettext translation (.MO) files
################################################################################
%.mo: %.po
	msgfmt --output=$@ $<
