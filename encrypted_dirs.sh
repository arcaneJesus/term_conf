# Encypted directories
source ~/.shellconfig/libs/kv-bash/kv-bash
encryptdir () {
  # encrypt and add to links
  if ![[ -e $1]]; then
    mkdir $1
  fi
  secret=$(readlink -f $1)
  userfacing=$(readlink -f $2)
  encfs $secret $userfacing
  fusermount -u $2
  kvset $secret $userfacing
}

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
