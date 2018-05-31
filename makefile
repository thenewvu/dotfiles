SRC := .config/mpv/mpv.conf .config/kitty/kitty.conf .tmux.conf .bashrc .npmrc .vimrc .eslintrc.yaml .bash_profile .gitconfig .vim .config/nvim
DST := $(addprefix ~/, $(SRC))

.PHONY: deploy
deploy: $(DST)

~/%: ${CURDIR}/% makefile
	mkdir -p $(dir $@); \
	ln -sf $< $@; \

.PHONY: clean
clean:
	@for f in $(DST); do \
		echo "Removing $$f"; \
		rm -rf $$f; \
	done
