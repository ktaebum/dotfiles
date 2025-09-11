#!/bin/bash

# Assumption: zsh & oh-my-zsh is installed

DOTFILES="$(pwd)"

function install_conda {
  echo "Install conda..."
  if [ ! -x "$(command -v conda)" ] ;
  then
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --directory-prefix=${HOME}/.local
    sh ${HOME}/.local/Miniconda3-latest-Linux-x86_64.sh -b -p ${HOME}/program/miniconda3
    rm ${HOME}/.local/Miniconda3-latest-Linux-x86_64.sh
  fi
}

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
    LATEST_TAG=$(git describe --abbrev=0)
    git checkout ${LATEST_TAG}
    make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=${HOME}/.local/nvim install
    cd ${DOTFILES}
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

  ln -s ${DOTFILES}/nvim ${NVIM_CONFIG_PATH}
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

  CATPPUCCIN_DIR="${HOME}/.config/tmux/plugins/catppuccin"
  if [ ! -d "${CATPPUCCIN_DIR}/tmux" ] ;
  then
    mkdir -p ${CATPPUCCIN_DIR} && git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ${CATPPUCCIN_DIR}/tmux
  fi

  ln -s ${DOTFILES}/tmux/tmux.conf ${TMUX_CONF_PATH}
}

function install_node {
  echo "Install node..."
  NODE_DIR="${HOME}/.local/node"
  if [ ! -d ${NODE_DIR} ] ;
  then
    NODE_VERSION="v22.12.0"
    NODE_TAR_FILE="node-${NODE_VERSION}-linux-x64.tar.xz"
    wget "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TAR_FILE}" -P "${HOME}/.local"
    mkdir -p "${HOME}/.local/node" && tar -xvf "${HOME}/.local/${NODE_TAR_FILE}" -C "${HOME}/.local/node" --strip-components=1
    rm -f "${HOME}/.local/${NODE_TAR_FILE}"
  fi
}

function install_ctags {
  echo "Install ctags..."

  if [ ! -d "${HOME}/.local/ctags" ] ;
  then
    # install ctags
    git clone https://github.com/universal-ctags/ctags.git ${HOME}/program/ctags
    cd ${HOME}/program/ctags
    git fetch --tags
    LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
    git checkout ${LATEST_TAG}
    ./autogen.sh
    ./configure --prefix=${HOME}/.local/ctags
    make && make install
    cd ${DOTFILES}
  fi
}

function install_rust {
  echo "Install rust..."
  if [ ! -x "$(command -v cargo)" ] ;
  then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
  fi
  cargo install ripgrep fd-find
}

function install_llvm {
  echo "Install llvm..."
  LLVM_DIR="${HOME}/.local/llvm"
  if [ ! -d ${LLVM_DIR} ] ;
  then
    UBUNTU_MAJOR_VERSION="$(lsb_release -rs | cut -d. -f1)"
    if [ ${UBUNTU_MAJOR_VERSION} = "24" ] || [ ${UBUNTU_MAJOR_VERSION} = "22" ]
    then
      LLVM_VERSION="20.1.4"
      LLVM_TAR_FILE="LLVM-${LLVM_VERSION}-Linux-X64.tar.xz"
    else
      LLVM_VERSION="18.1.8"
      LLVM_TAR_FILE="clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-18.04.tar.xz"
    fi
    wget "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/${LLVM_TAR_FILE}" -P ${HOME}/.local
    mkdir -p "${HOME}/.local/llvm" && tar -xvf "${HOME}/.local/${LLVM_TAR_FILE}" -C "${HOME}/.local/llvm" --strip-components=1
    rm -f "${HOME}/.local/${LLVM_TAR_FILE}"
  fi
}

function install_fzf {
  echo "Install fzf..."
  if [ ! -f "${HOME}/.local/bin/fzf" ];
  then
    FZF_VERSION="0.62.0"
    FZF_TAR_FILE="fzf-${FZF_VERSION}-linux_amd64.tar.gz"
    wget "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/${FZF_TAR_FILE}" -P ${HOME}/.local
    mkdir -p "${HOME}/.local/bin" && tar -zxvf "${HOME}/.local/${FZF_TAR_FILE}" -C "${HOME}/.local/bin"
    rm -f "${HOME}/.local/${FZF_TAR_FILE}"
  fi
}

function install_cmake {
  echo "Install cmake..."
  if [ ! -f "${HOME}/.local/cmake" ];
  then
    CMAKE_VERSION="3.31.5"
    CMAKE_TAR_FILE="cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz"
    wget "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_TAR_FILE}" -P ${HOME}/.local
    mkdir -p "${HOME}/.local/cmake" && tar -zxvf "${HOME}/.local/${CMAKE_TAR_FILE}" -C "${HOME}/.local/cmake" --strip-components=1
    rm -f "${HOME}/.local/${CMAKE_TAR_FILE}"
  fi
}

INSTALL_TARGET=$1

if [ "${INSTALL_TARGET}" == "all" ] ;
then
  install_conda
  install_zsh
  install_nvim
  install_tmux
  install_node
  install_ctags
  install_rust
  install_llvm
  install_fzf
  install_cmake
elif [ "${INSTALL_TARGET}" == "nvim" ] ;
then
  install_nvim
elif [ "${INSTALL_TARGET}" == "zsh" ] ;
then
  install_zsh
elif [ "${INSTALL_TARGET}" == "tmux" ] ;
then
  install_tmux
elif [ "${INSTALL_TARGET}" == "node" ] ;
then
  install_node
elif [ "${INSTALL_TARGET}" == "ctags" ] ;
then
  install_ctags
elif [ "${INSTALL_TARGET}" == "rust" ] ;
then
  install_rust
elif [ "${INSTALL_TARGET}" == "llvm" ] ;
then
  install_llvm
elif [ "${INSTALL_TARGET}" == "conda" ] ;
then
  install_conda
elif [ "${INSTALL_TARGET}" == "fzf" ] ;
then
  install_fzf
elif [ "${INSTALL_TARGET}" == "cmake" ] ;
then
  install_cmake
else
  echo "Not support: ${INSTALL_TARGET}"
  exit 1
fi
