# Dotfiles Stow Makefile

STOW ?= stow
DOTDIR := $(CURDIR)
MODULES := atuin fish fish-ai git starship tmux

.PHONY: all
all: stow

.PHONY: stow
stow:
	@for module in $(MODULES); do \
		echo "==> Stowing $$module..."; \
		$(STOW) -d $(DOTDIR) -t $$HOME $$module; \
	done

.PHONY: unstow
unstow:
	@for module in $(MODULES); do \
		echo "==> Unstowing $$module..."; \
		$(STOW) -d $(DOTDIR) -t $$HOME -D $$module; \
	done

.PHONY: stow-% unstow-%
stow-%:
	$(STOW) -d $(DOTDIR) -t $$HOME $*

unstow-%:
	$(STOW) -d $(DOTDIR) -t $$HOME -D $*

.PHONY: help
help:
	@echo "Dotfiles stow Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  stow                   - Stow all dotfile modules"
	@echo "  unstow                 - Unstow all dotfile modules"
	@echo "  stow-<name>            - Stow a single module (e.g. make stow-fish)"
	@echo "  unstow-<name>          - Unstow a single module"
