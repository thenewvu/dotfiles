dotfiles := .config/mpv/mpv.conf .config/kitty/kitty.conf .tmux.conf .bashrc .npmrc .vimrc .eslintrc.yaml .bash_profile .gitconfig .vim .config/nvim

.PHONY: deploy
deploy: $(dotfiles)
	@for f in $(dotfiles); do \
		mkdir -p $(dir ~/$$f); \
		echo "Linking $(addprefix ${CURDIR}/, $$f) -> ~/$$f"; \
		ln -sf $(addprefix ${CURDIR}/, $$f) ~/$$f; \
	done

.PHONY: clean
clean:
	@for f in $(dotfiles); do \
		echo "Removing ~/$$f"; \
		rm -fr ~/$$f; \
	done
