# setup GIT
    sudo pacman -S --noconfirm --needed gnome-keyring libsecret libgnome-keyring # needed for vscode-ssh authentifications
    git config --global user.email "lukasgraz99@gmail.com"
    git config --global user.name "LukasGraz"
    ssh-keygen -t ed25519 -C "lukasgraz99@gmail.com"
    sudo chmod 755 ~/.ssh
    sudo chmod 600 ~/.ssh/id_ed25519
    ssh-add ~/.ssh/id_ed25519
    # copy output of
    cat ~/.ssh/id_ed25519.pub  
    # and past the output to `GitHub -> Settings -> SSH and GPG Keys`
    ssh -T git@github.com # confirm with yes


# PIP / Python-modules
    pip3 install radian

# R setup
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
    Rscript -e "renv::init(project = '~/R/vscode-R'); renv::install(c('languageserver'))"
    # save the following output to vsconfig "r.libPaths" 
    Rscript -e "renv::paths[['library']]()"

# rclone (execute by hand)
    # go here: https://console.cloud.google.com/apis/credentials?project=psyched-circuit-342100
    # to get:
        # clienet id: 449832985581-n8rqi12a5c4d7r0buhrfh727rf3ngdfc.apps.googleusercontent.com
        # client secret: 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
    rclone config  
    # answer with:
        # n
        # gdrive / lpldrive
        # drive
        # 449832985581-n8rqi12a5c4d7r0buhrfh727rf3ngdfc.apps.googleusercontent.com
        # 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
        # 1
        # <accept all defaults from here>  &  <confirm in browser>
    rclone copy gdrive:AcerDacer ~/Documents
    # setup cron-job
    # ...


# create swapfile (run line by line)
    ## remove if necessary:
        # swapoff /swapfile
        # rm -f /swapfile
    sudo su
    cd /
    truncate -s 0 ./swapfile
    chattr +C ./swapfile
    dd if=/dev/zero of=/swapfile bs=1M count=10240 status=progress
    chmod 0600 /swapfile
    mkswap -U clear /swapfile
    swapon /swapfile
    echo "/swapfile none swap defaults 0 0" >> /etc/fstab
    exit


# polybox setup -> sudo pacman -S owncloud-client --needed
    # set server as: https://polybox.ethz.ch

# paperless
    sudo systemctl enable docker.service --now
    # download install_script
    curl -L https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/install-paperless-ngx.sh > ~/install_paperless

    # add option to edit docker-compose.yml befor pulling:
    sed -i '/${DOCKER_COMPOSE_CMD} pull/i /usr/bin/bash' ~/install_paperless
    # execute script
    ## !!! edit postgres version to 13: !!!
    ## !!! check directory paths !!!
    bash -c "$(cat ~/install_paperless)"
    # clean up
    rm ~/install_paperless

    # run soming like:
    # mv lukas_paperless_export ~/paperless-ngx/export
    # docker compose exec -T webserver document_importer ../export/lukas_paperless_export



# setup jekyll website
    # install ruby
    sudo pacman -S --noconfirm --needed ruby
    # install jekyll
    gem install jekyll bundler jekyll-paginate jekyll-sitemap jekyll-gist jekyll-feed jemoji jekyll-include-cache jekyll-algolia minimal-mistakes-jekyll github-pages tzinfo-data wdm --user-install
    # install theme
    git clone

    # https://github.com/mmistakes/mm-github-pages-starter
    # --> setup github if not already done

