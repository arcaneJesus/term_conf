#Default config
USE_POWERLINE="true"
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
# Background
alias lsbkg="ls /usr/share/backgrounds/user"
setbkg () {
  if [[ -e /usr/share/backgrounds/user/$1 ]]; then
    echo "set \$background \"/usr/share/backgrounds/user/$1\"" > ~/.config/sway/definitions.d/01-background.conf
    swaymsg reload
  else
    echo "File not found"
    return 4
  fi
  return 0
}
addbkg () {
  if [[ -e $1 ]]; then
    if ![[ -e /usr/share/backgrounds/user/$(basename $1) ]]; then
      sudo cp $1 /usr/share/backgrounds/user
      sudo chmod +x /usr/share/backgrounds/user/$(basename $1)
    else
      echo "File already present"
      return 3
    fi
  else
    echo "File not found"
    return 4
  fi
  return 0
}
newbkg () {
  addbkg $1
  setbkg $(basename $1)
  return 0
}
# Battery info
alias batf="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias bat="batf | grep updated; batf | head -n 24 | tail -n 15"
# System control
alias sysdo="sudo systemctl"
alias blkn="sudo sh -c 'vbetool dpms off; read ans; vbetool dpms on'"
alias rmchk="sudo dmidecode -t memory | grep Size"
# Config editing
alias rcsrc="source ~/.zshrc"
alias rcedit="nvim ~/.zshrc; rcsrc"
alias keycode="xev -event keyboard | egrep -o 'keycode.*\)'"
# Encypted directories
source ~/.shellconfig/libs/kv-bash/kv-bash
encryptdir () {
  if [[ $# == 0 ]]; then
    echo "encryptdir dir_name [secretdir_name]"
  # encrypt and add to links
  elif [[ $# == 1 ]]; then
    
  else
    secret=$(readlink -f $1)
    userfacing=$(readlink -f $2)
    encfs $secret $userfacing
    fusermount -u $2
    kvset $secret $userfacing
  fi
}

# if no args
#   echo help
# if one arg and main doesnt exist
#   make the main dir and secret dir
# if one arg and main exists
#   make secret dir
# if two args and main doesnt exist and secret doesnt exist
#   make both

# if no args
#   echo help
# if

opendir () {
  if [[ -e $1 ]]; then
    dir=$(readlink -f $1)
    secret=$(kvget $dir)
    encfs $secret $dir
  else
    echo "Dir not found"
  fi
}

closedir() {
  if [[ -e $1 ]] && [[ -z $(kvget $(readlink -f $1)) ]]; then
    fusermount -u $1
  else
    echo "error"
  fi
}
# Git
qedit () {
  pwb=$(git rev-parse --abbrev-ref HEAD)
  branch="$RANDOM$RANDOM$RANDOM$RANDOM"
  git checkout -b $name
  nvim $1
  echo "Enter commit message:"
  read msg
  if [[ -n $msg ]]; then
    git add $1
    git commit -m $msg
    checkout $pwb
    git merge $branch
    git branch -d $branch
  else
    git checkout $pwb
    git branch -d $branch
    echo "Mesage empty, aborting commit"
    return 5
  fi
  return 0
}
# Internet
alias wifi="nmcli dev wifi list"
alias connect="nmcli --ask connection up"
alias htspt="nmcli dev wifi connect Hotspot password ***REMOVED***"
alias pubip="wget -qO- http://ipecho.net/plain | xargs echo"
# Misc
alias idea="idea-ce"
alias typora="typora --enable-features=UseOzonePlatform --ozone-platform=wayland"
todir () {
  if [[ -e $1.* ]]; then
    mkdir $1
    mv $1.* $1
  else
    echo "File not found"
    return 4
  fi
  return 0
}
flw () {
  mv $1 $2 && cd $2
}
sflw () {
  sudo mv $1 $2 && cd $2
}

source /home/e/.config/broot/launcher/bash/br
# Pacman
alias inst="sudo pacman -S"
# PATH
export PATH=/home/e/.maven/bin:/home/e/.cargo/bin:/home/e/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct
# Rust
alias rustrepl="evcxr"
alias genwasm="cargo generate --git https://github.com/rustwasm/wasm-pack-template"
# System control
alias sysdo="sudo systemctl"
alias blkn="sudo sh -c 'vbetool dpms off; read ans; vbetool dpms on'"
alias rmchk="sudo dmidecode -t memory | grep Size"
# Tor
alias torup=". torsocks on"
alias tordn=". torsocks off"
alias toredit="sudoedit /etc/tor/torrc && sysdo restart tor"
# Vpn
alias nord="nordvpn"
alias nordup="timeout 30s nord connect us"
alias norddn="nord disconnect"
alias nordrs="norddn && nordup"
