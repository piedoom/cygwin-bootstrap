PATH=$1

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

# get menlo font
cd ..
git clone "https://github.com/abertsch/Menlo-for-Powerline"
cd Menlo-for-Powerline

# copy font to windows font directory
cp "Menlo for Powerline.ttf" "C:\\Windows\\Fonts"

echo "Installed menlo to windows.  You'll need to edit your Cygwin options to set it as default"

# remove temporarily downloaded files
cd ..
rm -rf "Menlo for Powerline"
rm -rf "mintty-colors-solarized"
rm apt-cyg


echo "Process completed.  Please restart your shell."
$SHELL