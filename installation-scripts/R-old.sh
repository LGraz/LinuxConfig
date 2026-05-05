# Download recent tar.gz

tar -xfvz ...
cd ...

./configure --enable-R-shlib
make
sudo make install


touch ~/.profile
sudo pacman -S --noconfirm --needed gcc r # to compile pacages
# sudo chmod -R 777 /usr/lib/R/library # make library free for alls
# temp="`R --version`" && temp=${temp:10:3}
# echo "export R_LIBS_USER=/home/lukas/R/x86_64-pc-linux-gnu-library/$temp" >> ~/.profile
mkdir ~/R
# colorout:
git clone https://github.com/jalvesaq/colorout.git
R CMD INSTALL colorout
rm -rf colorout
# renv for VSCode
Rscript -e "renv::init(project = '~/R/vscode-R'); renv::install(c('languageserver')); renv::paths[['library']]()"
# save the above output to vsconfig "r.libPaths"   #c.f. https://github.com/REditorSupport/vscode-R/wiki/Working-with-renv-enabled-projects
