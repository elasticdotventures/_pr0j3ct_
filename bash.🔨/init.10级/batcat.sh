## not presently using whiptail. 
#if n0ta_xfile_📁_好不好 "/usr/bin/whiptail" ; then 
#    # whiptail makes interactive menus
#    # 🤓 https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail
#    log_📢_记录 "😇.install whiptail menus"
#    $SUDO_CMD apt-get install -y whiptail
#fi

if n0ta_xfile_📁_好不好 "/usr/bin/batcat" ; then 
    log_📢_记录 "😇.install batcat (bat), replaces cat"
    URL=""
    case $ARCH in
        armv7l)
            URL="https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_armhf.deb" 
            ;;
        arm64) 
            URL="https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_arm64.deb"
            ;;
        x86_64)
            URL="https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_amd64.deb"
            ;;
        *) 
            log_📢_记录 "😇🐛 unsupported platform $ARCH"
            sleep 60
            ;;
    esac
    if [ -n "$URL" ] ; then 
        log_📢_记录 "😇batcat URL: $URL "
        pwdwas=`pwd`
        tmpdir=$(mktemp -d)
        cd $tmpdir && curl -LO $URL
        FILENAME=$(basename $URL)
        dpkg -i "$tmpdir/$FILENAME"
        cd $pwdwas
        #$SUDO_CMD apt install -y ./$FILENAME
        # $SUDO_CMD apt-get install -y bat
        #$SUDO_CMD mkdir -p ~/.local/bin
        #ln -s /usr/bin/batcat ~/.local/bin/bat
        # example how to use batcat with fzf:
        # fzf --preview 'batcat --style numbers,changes --color=always {} | head -50'
    fi
fi


