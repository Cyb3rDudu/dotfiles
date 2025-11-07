# Main Makefile - OS detection and dispatch
# Detects the operating system and delegates to OS-specific Makefiles

UNAME_S := $(shell uname -s)

.PHONY: help install link unlink clean

help:
	@echo "Dotfiles Makefile"
	@echo "================="
	@echo ""
	@echo "Detected OS: $(UNAME_S)"
	@echo ""
	@echo "Available targets:"
	@echo "  make install  - Install dependencies and symlink dotfiles"
	@echo "  make link     - Symlink dotfiles only (uses GNU Stow)"
	@echo "  make unlink   - Remove symlinks"
	@echo "  make clean    - Clean temporary files"
	@echo ""

install:
ifeq ($(UNAME_S),Darwin)
	@echo "Installing for macOS..."
	@$(MAKE) -f Makefile.darwin install
else ifeq ($(UNAME_S),Linux)
	@echo "Installing for Linux..."
	@$(MAKE) -f Makefile.linux install
else
	@echo "Unsupported OS: $(UNAME_S)"
	@exit 1
endif

link:
ifeq ($(UNAME_S),Darwin)
	@$(MAKE) -f Makefile.darwin link
else ifeq ($(UNAME_S),Linux)
	@$(MAKE) -f Makefile.linux link
endif

unlink:
	@echo "Unlinking dotfiles..."
	@stow -D -t $(HOME) bash fish zsh nushell tmux git || true

clean:
	@echo "Cleaning temporary files..."
	@find . -name '.DS_Store' -delete
	@find . -name '*.swp' -delete
	@find . -name '*~' -delete
