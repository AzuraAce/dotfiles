AzuraAce's Dotfiles
===================

Cloning
-------
```Shell
git clone --bare git@github.com:AzuraAce/dwm.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
