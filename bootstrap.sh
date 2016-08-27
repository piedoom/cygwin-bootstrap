PATH=$1

echo=$2

# remove old dotfiles
echo "Removing old dotfiles..."
rm -rf ~/.zshrc
rm -rf ~/.oh-my-zsh
rm -rf ~/.config

lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
install apt-cyg /bin
apt-cyg install wget

# install git
apt-cyg install git

# install vim
apt-cyg install vim

# install ssh
apt-cyg install openssh

# install zsh
apt-cyg install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# make terminal solarized
git clone "https://github.com/mavnn/mintty-colors-solarized"

cd mintty-colors-solarized
cat sol.dark >> ~/.zshrc
cat sol.dark >> ~/.bashrc

# remove temporarily downloaded files
rm -rf "mintty-colors-solarized"
rm apt-cyg

# change our mintty settings
touch ~/.minttyrc

echo "BoldAsFont=-1
Term=xterm-256color
Font=Menlo for Powerline
FontHeight=11
" >> ~/.minttyrc

echo "Process completed.  Please restart your shell."
$SHELL