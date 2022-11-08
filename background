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
