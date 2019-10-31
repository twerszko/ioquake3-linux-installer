#!/bin/bash

base=~/ioquake3
screen_width=1920
screen_height=1200

mkdir -p ~/q3_tmp && cd ~/q3_tmp

sudo apt-get install libc6 libglade2-0 unzip libsdl2-mixer-2.0-0 libsdl2-image-2.0-0 libsdl2-2.0-0 p7zip-full

wget -nc https://ioquake3.org/files/1.36/installer/ioquake3-1.36-7.1.x86_64.run
wget -nc https://ioquake3.org/files/1.36/data/ioquake3-q3a-1.32-9.run
wget -nc https://cdn.playmorepromode.com/files/cpma/cpma-1.52-nomaps.zip
wget -nc https://cdn.playmorepromode.com/files/cnq3/cnq3-1.51.zip
wget -nc http://ioquake3.org/files/xcsv_hires.zip
wget -nc https://cdn.playmorepromode.com/files/cpma-mappack-full.zip
#Download manually if gone (https://www.moddb.com/mods/high-quality-quake/downloads/hqq-v36)
wget -nc -O pak9hqq37test20181106.pk3 https://github.com/diegoulloao/ioquake3-mac-install/raw/master/extras/extra-pack-resolution.pk3
wget -nc -O pakxy01Tv5.pk3 https://github.com/diegoulloao/ioquake3-mac-install/raw/master/extras/hd-weapons.pk3
#wget -nc -O q3config.cfg https://gist.githubusercontent.com/oliveratgithub/b2df8ff2a76d1ff406f033701de66628/raw/2a6a856e3da322dca0e7090bb911244e11087c52/autoexec.cfg
wget -nc https://raw.githubusercontent.com/twerszko/ioquake3-linux-installer/master/config/q3config.cfg

wget -nc https://github.com/diegoulloao/ioquake3-mac-install/raw/master/dependencies/baseq3/pak0/pak0.z01
wget -nc https://github.com/diegoulloao/ioquake3-mac-install/raw/master/dependencies/baseq3/pak0/pak0.z02
wget -nc https://github.com/diegoulloao/ioquake3-mac-install/raw/master/dependencies/baseq3/pak0/pak0.z03
wget -nc https://github.com/diegoulloao/ioquake3-mac-install/raw/master/dependencies/baseq3/pak0/pak0.z04
wget -nc https://github.com/diegoulloao/ioquake3-mac-install/raw/master/dependencies/baseq3/pak0/pak0.zip
cat pak0\.* > pak0_all.zip

chmod +x ioquake3-1.36-7.1.x86_64.run
chmod +x ioquake3-q3a-1.32-9.run
# Use default settings and close installer afterwards
./ioquake3-1.36-7.1.x86_64.run
# Use default settings and close installer afterwards
./ioquake3-q3a-1.32-9.run

unzip cpma-1.52-nomaps.zip
mv cpma $base/

mkdir -p cnq3 && cd cnq3
unzip ../cnq3-1.51.zip
cd ..
mv cnq3/* $base/
chmod +x $base/cnq3-x64
rm -rf cnq3

unzip xcsv_hires.zip
cp xcsv_bq3hi-res.pk3 $base/baseq3/
mv xcsv_bq3hi-res.pk3 $base/cpma/

cp pak9hqq37test20181106.pk3 $base/baseq3/
mv pak9hqq37test20181106.pk3 $base/cpma/

cp pakxy01Tv5.pk3 $base/baseq3/
mv pakxy01Tv5.pk3 $base/cpma/

mkdir -p maps && cd maps
unzip ../cpma-mappack-full.zip
cd ..
mv maps/* $base/cpma/
rm -rf maps

unzip pak0_all.zip
cp pak0.pk3 $base/baseq3/
rm pak0_all.zip
rm pak0.pk3

rm -f *.txt

sed -i -e 's/^seta cl_renderer.*/seta cl_renderer "opengl1"/g' q3config.cfg
sed -i -e 's/^seta r_customwidth.*/seta r_customwidth "'"$screen_width"'"/g' q3config.cfg
sed -i -e 's/^seta r_width.*/seta r_width "'"$screen_width"'"/g' q3config.cfg
sed -i -e 's/^seta r_customheight.*/seta r_customheight "'"$screen_height"'"/g' q3config.cfg
sed -i -e 's/^seta r_height.*/seta r_height "'"$screen_height"'"/g' q3config.cfg
mkdir -p ~/.q3a/cpma/
test -f ~/.q3a/cpma/q3config.cfg || \
cp q3config.cfg ~/.q3a/cpma/q3config.cfg

cd $base && ./cnq3-x64

