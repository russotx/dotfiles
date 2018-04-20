#------------------------------------------------------------
#                WELCOME TO THE BASH PROFILE
#
#  ctrl+o followed by enter/return to save.
#  ctrl+x to exit.
#  activate changes by typeing 
#      source .bash_profile
#               or
#            srcprof   # (alias as defined below) 
#  at the prompt, or just exit terminal and open again.
#____________________________________________________________

#  add scripts to run at startup below...


#   change search directory for apps to Homebrew dir  
# ----------------------------------------------------------


#   bash completion
# ----------------------------------------------------------
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

# tmux completion
# ------------------------------------------------------------
eval "$(_TMUXP_COMPLETE=source tmuxp)"

# quicker commands
# ----------------------------------------------------------
alias c='clear'                                    # clear screen
alias rm='rm -i'  # force double checking
alias mv='mv -i' # force double checking
alias cp='cp -iv' # force double checking & more info
alias back='cd $OLDPWD' # go to last dir
alias cpwd="pwd | tr -d '\n' | pbcopy" # copy the current path to osx clipboard
alias v='pbpaste' # paste from osx clipboard  run as `v` to expand alias before running command
alias sprof='vim .bash_profile'                    # show the bash profile
alias srcprof='source .bash_profile'               # reload the bash profile
alias boot='cd ~/projects/bootcamp/'               # go to bootcamp projects folder
alias vi='vim'                                     # use vim
alias tmxC='tmux -CC'                               # start tmux session
alias tmxA='tmux attach'                       # attach to existing tmux session
alias tmxL='tmux list-sessions'                    # list all tmux sessions
alias tmxAT='tmux attach -t ' #<session-name>      # attach to a target session
alias tmxKTS="tmux kill-session -t " #<session-name> # kill a target session
alias tmxKSS="tmux kill-server"                      # appropriately kill all sessions
alias tmxKAOS="tmux kill-session -a"                  # when in session kill all OTHER sessions
alias tmxMDK='pkill -f tmux'                        # Murder Death Kill :p when outside tmux session kills all the tmux processes
alias tmxN='tmux new -s' #<new-sesh-name>           # create a new named session
alias vbm='VBoxManage' # run a command for Virtual Box
alias vbmC='VBoxManage createvm --name' #"<name>" --register   # create a new vm
alias vbmL='VBoxManage list -ls vms | less' # list all Virtual Box vm sorted with details
alias vbmLH='VBoxManage list hdds'  # list the hard disks
alias vbmI='VBoxManage showvminfo' #<vm name>  --details  # show info on a Virtual Box vm
alias vbmM='VBoxManage modifyvm' #<vm name>  [options]   # modify a Virtual Box vm
alias vbmGo='VBoxManage startvm' #<vm name> [options]   # start a Virtual Box vm
alias vbmSnap='VBoxManage snapshot' #<vm name> take|delete|restore|restorecurrent|edit|list|showvminfo <name|snapname>  
alias vbmCtl='VBoxManage controlvm' #<vm name> [command]   # control the vm from OSX
alias vbmCtrl='VBoxManage controlvm' #<vm name> [command]   # control the vm from OSX

# BOILERPLATE CODE FILES
# alias newtern='cp ~/Desktop/code/boilerplates/configs/.tern-project .'      # copies the boilerplate tern file to current dir
# alias newreactexpress='cp ~/Desktop/code/boilerplates/servers/reactexpress.js .' # copies the boilerplate reactexpress file
# alias newplainhtml='cp ~/Desktop/code/boilerplates/html/plain-html.html .' # copies a very basic html file
# alias newbshtml='cp ~/Desktop/code/boilerplates/html/bootstrap3-html.html .' # copies a plain html with bootstrap link included
# alias newcssreset='cp ~/Desktop/code/boilerplates/CSS/reset.css .' #copies reset css to cwd
# alias newbabel='cp ~/Desktop/code/boilerplates/configs/.babelrc .' #copies babel file with env plugin
# alias newbootstrap='cp ~/Desktop/code/boilerplates/html/bootstrap3-starter.html .' #copies bootstrap starter file with dns link

#-----------------------------------------------------------
# git aliases
alias gfu='git fetch upstream'                     #get upstream repo files
alias gmuM='git merge upstream/master'              #sync up with upstream repo
alias gall='git add -A'                            #add all git files changes
alias gbr='git branch'
alias gbrall='git branch -A'
alias gcm='git commit -m'                          #commit files and add message
alias gpoM='git push origin master'  #push to the master repo 

#---------------------------------------------------
# Connect to WP Engine Installs
nerd_mode () {
  ssh $1@$1.ssh.wpengine.net
}

# make BASH better
# ----------------------------------------------------------
# standard bash prompt 
# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# Bash prompt with Git integration
reset=$(tput sgr0)
bold=$(tput bold)
greenBg=$(tput setab 2)
black=$(tput setaf 0)
red=$(tput setaf 1)
redBg=$(tput setab 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
cyan=$(tput setaf 6)

function parse_git_color {
  $(git diff-index --quiet HEAD -- 2> /dev/null) 
  gitstatnum=$?
  if [[ $gitstatnum -eq 128 ]] 
  then
    echo "$reset" 
  elif [[ $gitstatnum -eq 0 ]]
  then
    echo "$greenBg"
  else
    echo "$redBg"
  fi
}

function parse_git_branch {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function show_git {
  gitstat=$(parse_git_color)
  if [[ $gitstat = $reset ]]
  then 
    echo "${gitstat}├ "
  elif [[ $gitstat = $greenBg ]]
  then
    echo -e "\n${white}├${greenBg}${black}  $(parse_git_branch) ${reset}─ "
  else 
    echo -e "\n${white}├${redBg}  $(parse_git_branch) ${reset}─ "
  fi
}

# wrap color change commands in \[ \] so Bash knows not to count them as columns
# do not wrap function calls in \[ \] if they echo text or that text won't be counted as a column
PS1="\n\[\033[38;5;11m\]\u\[$reset\] @\[$cyan\]\h\[$reset\]\$(show_git)\[$reset\]\[\033[38;5;33m\]\w\[$reset\]\n\[$bold\]└●►\[$reset\]\[$white\]"
PS2="\[$bold\]└●►\[$reset\]"
#  
# function to change dir and list contents
function nav {
    builtin cd "$@" && 'ls' -ACd .*/ */ && find . -maxdepth 1 -type f -printf "%f\n" 
}

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# ls options
#-------------------------------------------------- 
# use colors for ls 
export CLICOLOR=1
# colors for output
# a-h: black|red|green|brown|blue|magenta|cyan|grey
# caps A-H: bold+ black|red|green|brown|blue|magenta|cyan|grey 
# X=default foreground/background
# attr order: dir|symlink|socket|pipe|exec|blockspec|charspec|execuid|execgid|dirsticky|dir!sticky
export LSCOLORS=ExFxBxDxCxegedabagacad
# ls aliases
# CLICOLOR_FORCE needed because `ls -G` only works when output to terminal, below alias outputs to `less`
alias ll='CLICOLOR_FORCE= ls -lGFhAo | less -INSR' # use less 
alias ls='ls -lGFhAo' 
alias lsd='find . -type d -name' #<dir-name>  find a dir in active dir
alias lsf='find . -type f -name' #<file-name> find a file starting in the active dir
#--------------------------------------------------

export PATH="/usr/local/sbin:$PATH"

export NVM_DIR="/Users/Daniel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

