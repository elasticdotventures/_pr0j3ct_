##### 
## after a lot of moving around, it's clear 
## yq4 needs to be here, since it's used in a variety of menus
## for d1rd1ct (next)
installYQ=false
YQ4_VERSION="v4.8.0"
YQ4_BINARY="yq_linux_amd64"  # TODO: multiarch 
YQ4_MIN_VERSION="4.0.0"
YQ4_INSTALL_PATH="/usr/local/bin/yq4"

if n0ta_xfile_📁_好不好 "$YQ4_INSTALL_PATH" ; then
    log_📢_记录 "😲 yq4 does not appear to be installed, f1x1ng."
    # missing yq
    installYQ=true
else 
    # check yq version 
    log_📢_记录 "🧐 checking yq4"
    currentYQver="$(yq4 -V | sed 's/[^0-9\.]//g')" # note: yq v2*3 have different version string than yq4
    isYQokay=$(is_v3rs10n_大于 "$YQ4_MIN_VERSION" $currentYQver)
    log_📢_记录 "🧐 isYQokay:$isYQokay"
    if [ "$isYQokay" = false ] ; then
        # TODO: consent
        log_📢_记录 "👻👼 insufficient yq --version $currentYQver, f1x1ng."
        installYQ=true
        # $SUDO_CMD snap remove yq
        # $SUDO_CMD apt-get remove yq
        $SUDO_CMD rm /usr/bin/yq4 
        $SUDO_CMD rm /usr/local/bin/yq4
        $SUDO_CMD rm ~/.local/bin/yq4
    fi
fi

# there are TWO YQ's !!! fuck this. 
# https://github.com/kislyuk/yq

# 🍰 yq  - YAML config i/o    https://github.com/mikefarah/yq
# not using yq via snap.  way too old!! 
#if n0ta_xfile_📁_好不好 "/usr/bin/yq" ; then
#    systemctl status snapd.service
#    snap install yq
#fi
if [ "$installYQ" = true ] ; then 
    log_📢_记录 "🐧😇 upgrading $YQ4_INSTALL_PATH"
    tmpdir=$(mktemp -d)
    pwdwas=`pwd`
    cd $tmpdir && \
     wget https://github.com/mikefarah/yq/releases/download/${YQ4_VERSION}/${YQ4_BINARY}.tar.gz -O - |\
     tar xz && $SUDO_CMD cp ${YQ4_BINARY} "$YQ4_INSTALL_PATH" && \
     rm -f $YQ4_BINARY
    cd $pwdwas
    
    currentYQver="$(yq4 -V | cut -f 2 -d ' ')"
    isYQokay=$(is_v3rs10n_大于 "$YQ4_MIN_VERSION" $currentYQver)
    if n0ta_xfile_📁_好不好 "$YQ4_INSTALL_PATH" ; then
        log_📢_记录 "💩 STILL missing $YQ4_INSTALL_PATH (required for d1ctd1r)"
        exit
    elif [ "$isYQokay" = true ] ; then
        log_📢_记录 "😇🎉 yq4 installed"
    else
        log_📢_记录 "💩🍒 yq4 installed, but version still insufficient (wtf)"
    fi 
fi


