#!/bin/bash

# Assumption: zsh & oh-my-zsh is installed

DOTFILES="$(pwd)"

function install_zsh {
  echo "Install zshrc..."
  ZSHRC_PATH="${HOME}/.zshrc"
  ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  ZSH_THEMES_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
  if [ ! -d ${ZSH_PLUGINS_DIR}/zsh-autosuggestions ] ;
  then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_PLUGINS_DIR}/zsh-autosuggestions
  fi

  if [ ! -d ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting ] ;
  then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting
  fi

  if [ ! -d ${ZSH_THEMES_DIR}/spaceship-prompt ];
  then
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_THEMES_DIR/spaceship-prompt" --depth=1
    ln -s "$ZSH_THEMES_DIR/spaceship-prompt/spaceship.zsh-theme" "$ZSH_THEMES_DIR/spaceship.zsh-theme"
  fi

  if [ -L ${ZSHRC_PATH} ] ;
  then
    unlink ${ZSHRC_PATH}
  fi

  if [ -f ${ZSHRC_PATH} ] ;
  then
    rm ${ZSHRC_PATH}
  fi

  ln -s ${DOTFILES}/zsh/zshrc ${ZSHRC_PATH}
}

function install_nvim {
  echo "Install nvim..."

  if [ ! -d "${HOME}/.local/nvim" ] ;
  then
    # install neovim
    git clone https://github.com/neovim/neovim.git ${HOME}/program/neovim
    sudo apt-get update && sudo apt-get install -y ninja-build gettext cmake unzip curl
    cd ${HOME}/program/neovim
    git fetch --tags
    LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
    git checkout ${LATEST_TAG}
    make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=${HOME}/.local/nvim install
    cd ${DOTFILES}
  fi

  PACKER_DIR="${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"
  if [ ! -d ${PACKER_DIR} ] ;
  then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ${PACKER_DIR}
  fi
  NVIM_CONFIG_PATH="${HOME}/.config/nvim"
  mkdir -p "${HOME}/.config"

  if [ -L ${NVIM_CONFIG_PATH} ] ;
  then
    unlink ${NVIM_CONFIG_PATH}
  fi

  if [ -d ${NVIM_CONFIG_PATH} ] ;
  then
    rm -r ${NVIM_CONFIG_PATH}
  fi

  ln -s ${DOTFILES}/vim ${NVIM_CONFIG_PATH}
}

function install_tmux {
  echo "Install tmux..."
  TPM_DIR="${HOME}/.tmux/plugins/tpm"

  if [ ! -d ${TPM_DIR} ] ;
  then
    git clone https://github.com/tmux-plugins/tpm ${TPM_DIR}
  fi

  TMUX_CONF_PATH="${HOME}/.tmux.conf"

  if [ -L ${TMUX_CONF_PATH} ] ;
  then
    unlink ${TMUX_CONF_PATH}
  fi

  if [ -f ${TMUX_CONF_PATH} ] ;
  then
    rm ${TMUX_CONF_PATH}
  fi

  ln -s ${DOTFILES}/tmux/tmux.conf ${TMUX_CONF_PATH}
}

INSTALL_TARGET=$1

if [ "${INSTALL_TARGET}" == "all" ] ;
then
  install_zsh
  install_nvim
  install_tmux
elif [ "${INSTALL_TARGET}" == "nvim" ] ;
then
  install_nvim
elif [ "${INSTALL_TARGET}" == "zsh" ] ;
then
  install_zsh
elif [ "${INSTALL_TARGET}" == "tmux" ] ;
then
  install_tmux
else
  echo "Not support: ${INSTALL_TARGET}"
  exit 1
fi
