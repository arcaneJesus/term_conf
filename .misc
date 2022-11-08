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
