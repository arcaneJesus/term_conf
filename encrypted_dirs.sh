# Encypted directories
source ./kv-bash
encryptdir () {
  if ![[ -e ~/.links.csv ]]; then
    touch ~/.links.csv
  fi
  # encrypt and add to links
  if ![[ -e $1]]; then
    mkdir $1
  fi
  secret=$(readlink -f $1)
  userfacing=$(readlink -f $2)
  encfs $secret $userfacing
  fusermount -u $2
  echo "$secret, $userfacing" >> ~/.links.csv
}

opendir () {
  if [[ -e $1 ]]; then
    
  fi
}
