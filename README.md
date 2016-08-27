## cygwin bootstrap

An extremely hacky way of setting up Cygwin the way I like it.  Developed by someone who has no idea how to use PowerShell.

## how to use

run `init.ps1` in a PowerShell instance.  You need to run as administrator, but
if you don't it'll prompt you with UAC.

The process will install Cygwin with the GUI.  Once you are done, press "ENTER" in 
PowerShell to continue.  It will now make mintty pretty.  

right now, when mintty is setting up, you need to press ctrl+D once 
oh-my-zsh is installed (since it opens a new shell)

After that, you're done.  We also already set the font for your terminal.

Copy "Cygwin Terminal" or "Cygwin64 Terminal" to your desktop.  This will open 
ZSH by default instead of bash.

## why?

I have to use Windows computers with deep-freeze at college often.  I *could* bring a flash drive with a *nix system or Cygwin already set up, 
but I always forget them.

## what i learned

PowerShell sucks.