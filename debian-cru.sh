#!/bin/bash
#
# Script de pós-instalação Debian 7.0 aka Wheezy
#
# Autor 	: Ernane Olivio <ernane.olivio@gmail.com>
# Nome  	: debian-cru.sh
# Descrição	: Instalação CRUA do Debian Server
# Data 		: 2014/09
# Versão	: 1.0
# Licenç	: BSD
# Sobre		: Cria instalação com requisítos mínimos de segurança do Debian para ser utilizada em ambiente de produção.
#
#
###



#==========================================================
# Applications to be installed: Check your network security
PACOTES="debian-archive-keyring build-essential harden vim \
dnsutils unzip bzip2 unrar curl git cfengine3 fail2ban \
logwatch lsb-release sudo"
#==========================================================
 
#
# Verifica se o usuário é root
#
if [ $EUID -ne 0 ]; then
    echo "Erro: Você deve ser root para poder executar este script, por favor utilize o usuário root ou sudo."
    exit 1
fi

if [ ! -f /etc/debian_version ]; then 
    echo "Distribuição Linux não suportada. Este script foi feito para Debian"
    exit 1
fi


# Closest mirror
echo "Iniciando a instalação - Debian 7 -x64..."
echo "  [1] C3SL mirror ..."

echo "" > /etc/apt/sources.list
cat >> /etc/apt/sources.list <<EOF
### C3SL mirror
### Chave GPG: apt-get install debian-archive-keyring

### Debian 7.0 Wheezy.
deb http://ftp.br.debian.org/debian/ wheezy main contrib non-free
deb-src http://ftp.br.debian.org/debian/ wheezy main contrib non-free
deb http://linorg.usp.br/debian/ wheezy main contrib non-free
deb-src http://linorg.usp.br/debian/ wheezy main contrib non-free

### Debian 7.0 Wheezy Security 'Updates'.
deb http://ftp.br.debian.org/debian-security/ wheezy/updates main contrib non-free
deb-src http://ftp.br.debian.org/debian-security/ wheezy/updates main contrib non-free
deb http://linorg.usp.br/debian-security/ wheezy/updates main contrib non-free
deb-src http://linorg.usp.br/debian-security/ wheezy/updates main contrib non-free

### Debian 7.0 Wheezy Updates 'Volatile'.
deb http://ftp.br.debian.org/debian/ wheezy-updates main contrib non-free
deb-src http://ftp.br.debian.org/debian/ wheezy-updates main contrib non-free
deb http://linorg.usp.br/debian/ wheezy-updates main contrib non-free
deb-src http://linorg.usp.br/debian/ wheezy-updates main contrib non-free

### Debian 7.0 Wheezy 'Proposed Updates'.
deb http://ftp.br.debian.org/debian/ wheezy-proposed-updates main contrib non-free
deb-src http://ftp.br.debian.org/debian/ wheezy-proposed-updates main contrib non-free
deb http://linorg.usp.br/debian/ wheezy-proposed-updates main contrib non-free
deb-src http://linorg.usp.br/debian/ wheezy-proposed-updates main contrib non-free

### Debian 7.0 Wheezy 'Backports'.
deb http://ftp.br.debian.org/debian/ wheezy-backports main contrib non-free
deb-src http://ftp.br.debian.org/debian/ wheezy-backports main contrib non-free
deb http://linorg.usp.br/debian/ wheezy-backports main contrib non-free
deb-src http://linorg.usp.br/debian/ wheezy-backports main contrib non-free
EOF

# Update
echo "  [2]Atualizando a lista de repositorios..."
aptitude update

# Upgrade
echo "  [3]Atualizando o sistema..."
aptitude safe-upgrade

# Instalando os pacotes básicos
echo "  [4]My base apps  ..."
aptitude -y install $PACOTES
               
# Python app environment
#apt-get -y install python-dev python-dev python-setuptools python-virtualenv
