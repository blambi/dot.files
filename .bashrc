export HISTCONTROL="ignoredups"

alias rmb="rm -v *\~"
alias ls="ls --color=auto"
alias findbackups="find ./ -name '*~'"
alias makedistro="drush make --no-core --contrib-destination=. --working-copy"

if [ -d "$HOME/opt/bin" ]; then
    PATH=$PATH:$HOME/opt/bin
fi

if [ -d "$HOME/opt/hacks/bin" ]; then
    PATH=$PATH:$HOME/opt/hacks/bin
fi

if [ -d "$HOME/opt/python" ]; then
    PYTHONPATH=$PYTHONPATH:$HOME/opt/python
    export PYTHONPATH
fi

# Modules
for mod in $HOME/opt/bash-mod/*.sh; do
    if [ -x $mod ]; then
        source $mod
    fi
done

if [ $USER != "root" ]; then
    PS1="\[\033[35m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
else
    PS1="\[\033[31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
fi
