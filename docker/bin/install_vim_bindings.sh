#!/usr/bin/env bash

if [ "$INSTALL_VIM_BINDINGS" = "true" ]; then
  # Create required directory in case (optional)
  EXTENSIONS_DIR="$(jupyter --data-dir)/nbextensions"
  echo "Installing vim bindings into $EXTENSIONS_DIR..."
  mkdir -p $EXTENSIONS_DIR
  # Clone the repository
  cd $EXTENSIONS_DIR || { echo "Error changing directory to $EXTENSIONS_DIR"; exit 1; }
  git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
  # Activate the extension
  jupyter nbextension enable vim_binding/vim_binding
fi