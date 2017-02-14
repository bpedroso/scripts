 #!/bin/bash

user=$1
proxyhost=$2
proxyport=$3

noProxy() {
  gsettings reset-recursively org.gnome.system.proxy
  cp ~/.m2/settings-noproxy.xml ~/.m2/settings.xml
  cp ~/dev/hybris-commerce-suite-5.7.0.15/build-tools/apache-maven/conf/settings-noproxy.xml ~/dev/hybris-commerce-suite-5.7.0.15/build-tools/apache-maven/conf/settings.xml
  cp /opt/apache-maven-3.3.9/conf/settings-noproxy.xml /opt/apache-maven-3.3.9/conf/settings.xml
  cp ~/.gitconfig-noproxy ~/.gitconfig

  sudo mv /etc/systemd/system/docker.service.d/http-proxy.conf /etc/systemd/system/docker.service.d/http-proxy.conf.bkp
}

c4Proxy() {
  gsettings set org.gnome.system.proxy use-same-proxy true
  gsettings set org.gnome.system.proxy mode 'manual'
  gsettings set org.gnome.system.proxy.http host $proxyhost
  gsettings set org.gnome.system.proxy.http port $proxyport
  gsettings set org.gnome.system.proxy.http use-authentication true
  gsettings set org.gnome.system.proxy.http authentication-password $password
  gsettings set org.gnome.system.proxy.http authentication-user $user
  gsettings set org.gnome.system.proxy.http enabled true

  gsettings set org.gnome.system.proxy.ftp host $proxyhost
  gsettings set org.gnome.system.proxy.ftp port $proxyport
  gsettings set org.gnome.system.proxy.socks host $proxyhost
  gsettings set org.gnome.system.proxy.socks port $proxyport
  gsettings set org.gnome.system.proxy.https host $proxyhost
  gsettings set org.gnome.system.proxy.https port $proxyport

  gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1']"

  cp ~/.m2/settings-proxy.xml ~/.m2/settings.xml
  cp ~/dev/hybris-commerce-suite-5.7.0.15/build-tools/apache-maven/conf/settings-proxy.xml ~/dev/hybris-commerce-suite-5.7.0.15/build-tools/apache-maven/conf/settings.xml
  cp /opt/apache-maven-3.3.9/conf/settings-proxy.xml /opt/apache-maven-3.3.9/conf/settings.xml
  cp ~/.gitconfig-proxy ~/.gitconfig

  sudo mv /etc/systemd/system/docker.service.d/http-proxy.conf.bkp /etc/systemd/system/docker.service.d/http-proxy.conf
}

if [ "$1" = "off" ]; then
  echo "deactivating proxy" & noProxy
else
  echo -n Write password for user $1 Password:
  read -s password
  echo
  c4Proxy
fi

#gsettings list-recursively org.gnome.system.proxy
echo "Finished !!"
