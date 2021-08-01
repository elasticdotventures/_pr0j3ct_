## not presently using whiptail. 
#if n0ta_xfile_📁_好不好 "/usr/bin/whiptail" ; then 
#    # whiptail makes interactive menus
#    # 🤓 https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail
#    log_📢_记录 "😇.install whiptail menus"
#    $SUDO_CMD apt-get install -y whiptail
#fi
log_📢_记录 "🥾: init.10级/batcat.sh"


function checkOS() {
    export ARCH6="$(uname -m | cut -b 1-6)" # 6 relevant characters, lolz. x86_64
    IS_supported=`cat /etc/os-release | grep "Ubuntu 20.04.2 LTS"`
    if [ -z "$IS_supported" ] ; then
        cat /etc/os-release
        log_📢_记录 "👽不支持  OS not yet supported." && exit 0
        return 1
    else
        log_📢_记录 "👍 OS is supported $ARCH6"
    fi

    return 0 
}
checkOS


if n0ta_xfile_📁_好不好 "/usr/bin/batcat" ; then 
    log_📢_记录 "😇.install batcat (bat), replaces cat  (🐛? arch6:$ARCH6)"
    URL=""
    case "$ARCH6" in
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
            log_📢_记录 "😇🐛 unsupported platform $ARCH6"
            sleep 60
            ;;
    esac
    if [ -n "$URL" ] ; then 
        log_📢_记录 "😇batcat URL: $URL "
        pwdwas=`pwd`
        tmpdir=$(mktemp -d)
        cd $tmpdir && curl -LO $URL
        FILENAME=$(basename $URL)
        sudo dpkg -i "$tmpdir/$FILENAME"
        cd $pwdwas
        # cheap hack to get thsi working the way i expect it to! 
        sudo ln -fs /usr/bin/bat /usr/bin/batcat

        #$SUDO_CMD apt install -y ./$FILENAME
        # $SUDO_CMD apt-get install -y bat
        #$SUDO_CMD mkdir -p ~/.local/bin
        #ln -s /usr/bin/batcat ~/.local/bin/bat
        # example how to use batcat with fzf:
        # fzf --preview 'batcat --style numbers,changes --color=always {} | head -50'
    fi
fi


