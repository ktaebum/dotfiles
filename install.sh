### zsh link
ln -s ~/.dotfiles/zsh/zshrf ~/.zshrc

### tmux link
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

### vimrc link
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/.dotfiles/vim/ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py
vim +PluginInstall +qall

python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

### style files
ln -s ~/.dotfiles/styles/clang-format ~/.clang-format
ln -s ~/.dotfiles/styles/style_yapf ~/.style.yapf
