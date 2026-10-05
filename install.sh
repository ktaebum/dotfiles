#!/bin/bash

# Assumption: zsh & oh-my-zsh is installed

DOTFILES="$(pwd)"
PLATFORM_OS="$(uname -s)"
PLATFORM_ARCH="$(uname -m)"

function unsupported_platform {
  echo "Unsupported platform: ${PLATFORM_OS} ${PLATFORM_ARCH}"
  return 1
}

function install_conda {
  echo "Install conda..."
  if [ ! -x "$(command -v conda)" ] ;
  then
    case "${PLATFORM_OS}:${PLATFORM_ARCH}" in
      Linux:x86_64) CONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh" ;;
      Linux:aarch64|Linux:arm64) CONDA_INSTALLER="Miniconda3-latest-Linux-aarch64.sh" ;;
      Darwin:arm64) CONDA_INSTALLER="Miniconda3-latest-MacOSX-arm64.sh" ;;
      Darwin:x86_64) CONDA_INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh" ;;
      *) unsupported_platform; return 1 ;;
    esac

    CONDA_INSTALLER_PATH="${HOME}/.local/${CONDA_INSTALLER}"
    mkdir -p "${HOME}/.local" "${HOME}/program"
    curl -fL "https://repo.anaconda.com/miniconda/${CONDA_INSTALLER}" -o "${CONDA_INSTALLER_PATH}"
    sh "${CONDA_INSTALLER_PATH}" -b -p "${HOME}/program/miniconda3"
    rm "${CONDA_INSTALLER_PATH}"
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

function install_starship {
  echo "Install starship..."
  if [ ! -x "$(command -v starship)" ] ;
  then
    mkdir -p "${HOME}/.local/bin"
    curl -sS https://starship.rs/install.sh | sh -s -- -y -b "${HOME}/.local/bin"
  fi

  STARSHIP_CONFIG_PATH="${HOME}/.config/starship.toml"
  mkdir -p "${HOME}/.config"

  if [ -L "${STARSHIP_CONFIG_PATH}" ] ;
  then
    unlink "${STARSHIP_CONFIG_PATH}"
  fi

  if [ -f "${STARSHIP_CONFIG_PATH}" ] ;
  then
    rm "${STARSHIP_CONFIG_PATH}"
  fi

  ln -s "${DOTFILES}/starship/starship.toml" "${STARSHIP_CONFIG_PATH}"
}

function install_ghostty {
  if [ "${PLATFORM_OS}" != "Darwin" ] ;
  then
    echo "Skip ghostty config: macOS only"
    return
  fi

  echo "Install ghostty config..."
  GHOSTTY_CONFIG_PATH="${HOME}/.config/ghostty"
  mkdir -p "${HOME}/.config"

  if [ -L "${GHOSTTY_CONFIG_PATH}" ] ;
  then
    unlink "${GHOSTTY_CONFIG_PATH}"
  fi

  if [ -e "${GHOSTTY_CONFIG_PATH}" ] ;
  then
    rm -r "${GHOSTTY_CONFIG_PATH}"
  fi

  ln -s "${DOTFILES}/ghostty" "${GHOSTTY_CONFIG_PATH}"
}

function install_nvim {
  if [ "${PLATFORM_OS}" != "Linux" ] ;
  then
    echo "Skip nvim: Linux only"
    return
  fi

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
    NODE_VERSION="v24.14.0"
    case "${PLATFORM_OS}:${PLATFORM_ARCH}" in
      Linux:x86_64) NODE_PLATFORM="linux-x64"; NODE_EXTENSION="tar.xz" ;;
      Linux:aarch64|Linux:arm64) NODE_PLATFORM="linux-arm64"; NODE_EXTENSION="tar.xz" ;;
      Darwin:arm64) NODE_PLATFORM="darwin-arm64"; NODE_EXTENSION="tar.gz" ;;
      Darwin:x86_64) NODE_PLATFORM="darwin-x64"; NODE_EXTENSION="tar.gz" ;;
      *) unsupported_platform; return 1 ;;
    esac

    NODE_TAR_FILE="node-${NODE_VERSION}-${NODE_PLATFORM}.${NODE_EXTENSION}"
    mkdir -p "${HOME}/.local/node"
    curl -fL "https://nodejs.org/dist/${NODE_VERSION}/${NODE_TAR_FILE}" -o "${HOME}/.local/${NODE_TAR_FILE}"
    tar -xf "${HOME}/.local/${NODE_TAR_FILE}" -C "${HOME}/.local/node" --strip-components=1
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
  cargo install ripgrep fd-find tree-sitter-cli stylua
}

function install_llvm {
  echo "Install llvm..."
  LLVM_DIR="${HOME}/.local/llvm"
  if [ ! -d ${LLVM_DIR} ] ;
  then
    LLVM_VERSION="23.1.2"
    case "${PLATFORM_OS}:${PLATFORM_ARCH}" in
      Linux:x86_64) LLVM_PLATFORM="Linux-X64" ;;
      Linux:aarch64|Linux:arm64) LLVM_PLATFORM="Linux-ARM64" ;;
      Darwin:arm64) LLVM_PLATFORM="macOS-ARM64" ;;
      *) unsupported_platform; return 1 ;;
    esac

    LLVM_TAR_FILE="LLVM-${LLVM_VERSION}-${LLVM_PLATFORM}.tar.xz"
    mkdir -p "${HOME}/.local/llvm"
    curl -fL "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/${LLVM_TAR_FILE}" -o "${HOME}/.local/${LLVM_TAR_FILE}"
    tar -xf "${HOME}/.local/${LLVM_TAR_FILE}" -C "${HOME}/.local/llvm" --strip-components=1
    rm -f "${HOME}/.local/${LLVM_TAR_FILE}"
  fi
}

function install_fzf {
  echo "Install fzf..."
  if [ ! -f "${HOME}/.local/bin/fzf" ];
  then
    FZF_VERSION="0.62.0"
    case "${PLATFORM_OS}:${PLATFORM_ARCH}" in
      Linux:x86_64) FZF_PLATFORM="linux_amd64" ;;
      Linux:aarch64|Linux:arm64) FZF_PLATFORM="linux_arm64" ;;
      Darwin:arm64) FZF_PLATFORM="darwin_arm64" ;;
      Darwin:x86_64) FZF_PLATFORM="darwin_amd64" ;;
      *) unsupported_platform; return 1 ;;
    esac

    FZF_TAR_FILE="fzf-${FZF_VERSION}-${FZF_PLATFORM}.tar.gz"
    mkdir -p "${HOME}/.local/bin"
    curl -fL "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/${FZF_TAR_FILE}" -o "${HOME}/.local/${FZF_TAR_FILE}"
    tar -xf "${HOME}/.local/${FZF_TAR_FILE}" -C "${HOME}/.local/bin"
    rm -f "${HOME}/.local/${FZF_TAR_FILE}"
  fi
}

function install_cmake {
  echo "Install cmake..."
  CMAKE_DIR="${HOME}/.local/cmake"
  if [ ! -d "${CMAKE_DIR}" ];
  then
    CMAKE_VERSION="3.31.11"
    case "${PLATFORM_OS}:${PLATFORM_ARCH}" in
      Linux:x86_64) CMAKE_PLATFORM="linux-x86_64" ;;
      Linux:aarch64|Linux:arm64) CMAKE_PLATFORM="linux-aarch64" ;;
      Darwin:arm64|Darwin:x86_64) CMAKE_PLATFORM="macos-universal" ;;
      *) unsupported_platform; return 1 ;;
    esac

    CMAKE_TAR_FILE="cmake-${CMAKE_VERSION}-${CMAKE_PLATFORM}.tar.gz"
    mkdir -p "${CMAKE_DIR}"
    curl -fL "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_TAR_FILE}" -o "${HOME}/.local/${CMAKE_TAR_FILE}"
    tar -xf "${HOME}/.local/${CMAKE_TAR_FILE}" -C "${CMAKE_DIR}" --strip-components=1
    rm -f "${HOME}/.local/${CMAKE_TAR_FILE}"

    if [ "${PLATFORM_OS}" = "Darwin" ] ;
    then
      ln -s "${CMAKE_DIR}/CMake.app/Contents/bin" "${CMAKE_DIR}/bin"
    fi
  fi
}

function install_gh {
  echo "Install gh..."
  if [ ! -f "${HOME}/.local/gh/bin/gh" ];
  then
    GH_VERSION="2.88.0"
    case "${PLATFORM_OS}:${PLATFORM_ARCH}" in
      Linux:x86_64) GH_PLATFORM="linux_amd64"; GH_EXTENSION="tar.gz" ;;
      Linux:aarch64|Linux:arm64) GH_PLATFORM="linux_arm64"; GH_EXTENSION="tar.gz" ;;
      Darwin:arm64) GH_PLATFORM="macOS_arm64"; GH_EXTENSION="zip" ;;
      Darwin:x86_64) GH_PLATFORM="macOS_amd64"; GH_EXTENSION="zip" ;;
      *) unsupported_platform; return 1 ;;
    esac

    GH_ARCHIVE="gh_${GH_VERSION}_${GH_PLATFORM}.${GH_EXTENSION}"
    mkdir -p "${HOME}/.local/gh"
    curl -fL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/${GH_ARCHIVE}" -o "${HOME}/.local/${GH_ARCHIVE}"
    tar -xf "${HOME}/.local/${GH_ARCHIVE}" -C "${HOME}/.local/gh" --strip-components=1
    rm -f "${HOME}/.local/${GH_ARCHIVE}"
  fi
}

function install_claude {
  echo "Install claude..."
  if [ ! -f "${HOME}/.local/bin/claude" ];
  then
    curl -fsSL https://claude.ai/install.sh | bash
  fi
}

function install_opencode {
  echo "Install opencode..."
  if [ ! -f "${HOME}/.opencode/bin/opencode" ];
  then
    curl -fsSL https://opencode.ai/install | bash
  fi
}

function install_uv {
  echo "Install uv..."
  if [ ! -x "$(command -v uv)" ] ;
  then
    mkdir -p "${HOME}/.local/bin"
    curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="${HOME}/.local/bin" UV_NO_MODIFY_PATH=1 sh
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
  install_gh
  install_claude
  install_opencode
  install_uv
  install_starship
  install_ghostty
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
elif [ "${INSTALL_TARGET}" == "gh" ] ;
then
  install_gh
elif [ "${INSTALL_TARGET}" == "uv" ] ;
then
  install_uv
elif [ "${INSTALL_TARGET}" == "starship" ] ;
then
  install_starship
elif [ "${INSTALL_TARGET}" == "ghostty" ] ;
then
  install_ghostty
else
  echo "Not support: ${INSTALL_TARGET}"
  exit 1
fi
