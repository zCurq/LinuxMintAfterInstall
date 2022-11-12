#!/usr/bin/bash

yesil='\e[0;32m'
turkuaz='\e[0;36m'
kirmizi='\e[1;31m'
mavi='\e[1;34m'
temizle='\e[0m'

if [ "$EUID" -ne 0 ]
  then echo -e "${kirmizi} Lütfen root yetkisi ile tekrar deneyiniz. ${temizle}"
  exit
fi


# Gerekli Konfigürasyonlar

echo -e "${yesil}########## Gerekli Konfigürasyonlar Ayarlanıyor ##########${temizle}"

sed -i.bak -e '$a\' -e 'Defaults timestamp_timeout=-1' -e '/Defaults timestamp_timeout=.*/d' /etc/sudoers
apt update -y && apt install curl git wget -y && apt upgrade -y

# Uygulamalar Kaldırılıyor
echo -e "${yesil}######### Uygulamalar Kaldırılıyor ##########${temizle}"
apt purge firefox hexchat thunderbird celluloid hypnotix -y 

# Uygulamalar kuruluyor
echo -e "${yesil}########## Uygulamalar Kuruluyor ###########${temizle}"
wget "discord.com/api/download?platform=linux" -O discord.deb && apt install ./discord.deb -y && rm discord.deb #Discord
curl -# https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output googlechrome.deb && apt install ./googlechrome.deb -y && rm googlechrome.deb #Google Chrome
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update -y && sudo apt-get install spotify-client -y 
sudo apt install plank cmake g++ -y
sudo apt install steam -y
sudo apt install wine-installer -y
sudo apt install tlp -y

# Temalar Kuruluyor
echo -e "${yesil}########## Temalar Kuruluyor ##########${temizle}"
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
bash install.sh && cd .. && rm -rf WhiteSur-gtk-theme
git clone https://github.com/vinceliuice/Colloid-icon-theme.git
cd Colloid-icon-theme
bash install.sh && cd .. && rm -rf Colloid-icon-theme

echo -e "${yesil}########## Gereksiz Artıklar Kaldırılıyor ##########${temizle}"
sudo apt autoremove -y

echo -e "${kirmizi}Sistem yeniden başlatılsın mı ?${temizle} ${turkuaz}( evet / hayır )${temizle} \n=>"
read cevap

if [[ $cevap == "evet" ]] ; then
    reboot
else
    echo -e "${turkuaz}Tüm işlemler başarı ile sonlandı !${temizle}"
fi
