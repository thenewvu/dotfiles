SRC := $(shell find -L . -type fl -not -path "**/.git/*" -not -path "**/undo/**" -not -path "**/plugged/**" -not -path "./makefile" | sed "s|^\./||")
DST := $(addprefix ~/, $(SRC))

.PHONY: list
list:
	@for f in $(SRC); do \
		echo "$$f -> $(addprefix ~/, $$f)"; \
	done

.PHONY: deploy
deploy: $(DST)

~/%: ${CURDIR}/%
	mkdir -p $(dir $@); \
	ln -sf $< $@; \

.PHONY: clean
clean:
	@for f in $(DST); do \
		echo "Removing $$f"; \
		rm -rf $$f; \
	done
