.PHONY: init test test-root push gen-pass

FLUTTER ?= flutter

init:
	$(FLUTTER) pub global activate encrypt
	$(FLUTTER) pub get

test: test-root

test-root:
	$(FLUTTER) test

gen-pass:
	secure-random

push: test
	git add .
	git commit -m "$(shell date '+%Y-%m-%d %H:%M')" || true
	git push
