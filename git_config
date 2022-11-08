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
