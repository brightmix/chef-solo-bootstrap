#!/bin/sh

# originally from http://gist.github.com/raw/132506/755496f8faca82702ae331a077db8784e45f3499/gistfile1.txt
#  via http://github.com/retr0h/chef_solo_os

trap "exit 2" 1 2 3 13 15

##
# Ubuntu.
if [ -f "/etc/lsb-release" ]; then
  ### Supported releases.
  #ISSUE="`awk '{print $2}' /etc/issue`"
  ISSUE="`awk -F"[ |.]" '{print $2$3}' /etc/issue`"
  case "${ISSUE}" in
    804) RELEASE="hardy" ;;
    810) RELEASE="intrepid" ;;
    904) RELEASE="jaunty" ;;
    910) RELEASE="karmic" ;;
    *) echo "[ERROR] Release '${ISSUE}' not supported!" && exit ;;
  esac

  ### Enable universe sources.
  sed -i -e 's/#deb/deb/g' /etc/apt/sources.list

  ### Add opscode sources to apt-get.
  echo "deb http://apt.opscode.com/ ${RELEASE} universe" > /etc/apt/sources.list.d/opscode.list
  curl http://apt.opscode.com/packages@opscode.com.gpg.key | apt-key add - || exit 1
  apt-get update -y

  ### Upgrade all packages.
  apt-get upgrade -y --force-yes

  ### No Docs.
  echo "gem: --no-user-install --no-rdoc --no-ri" > ${HOME}/.gemrc

  ### Install Chef.
  apt-get install -y ohai chef

  ### Install Git.
  #apt-get install -y git-core

  ### Install Ruby.
  apt-get install -y ruby ruby1.8-dev rubygems libopenssl-ruby1.8 libsqlite3-ruby rdoc ri irb build-essential

  ### Run chef solo.
  #cd /tmp && git clone git://github.com/retr0h/chef_solo_os.git && cd /tmp/chef_solo_os || exit 1
  #chef-solo -l debug -c config/solo.rb -j config/dna.json
else
  echo "[ERROR] OS unsupported."
fi


exit 0