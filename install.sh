### zsh link
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -L -o ~/.oh-my-zsh/custom/themes/materialshell.zsh-theme https://raw.githubusercontent.com/carloscuesta/materialshell/master/materialshell.zsh
curl -L https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme > ~/.oh-my-zsh/custom/themes/gruvbox.zsh-theme
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm ~/.zshrc
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
bash -c "$(curl -fsSL https://raw.githubusercontent.com/skylerlee/zeta-zsh-theme/master/scripts/install.sh)"

### tmux link
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### vimrc link
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/.dotfiles/vim/ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py
vim +PluginInstall +qall

### YCM install
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

### style files
ln -s ~/.dotfiles/styles/clang-format ~/.clang-format
ln -s ~/.dotfiles/styles/style_yapf ~/.style.yapf
ln -s ~/.dotfiles/styles/pylintrc ~/.pylintrc
ln -s ~/.dotfiles/styles/ctags ~/.ctags
