#!/bin/bash 

## * * * *// 
#* Purpose: imports standard bash behaviors
#*          for consistent handling of parameters
#*
##  note: when running by hand, this extends shell env.
##  must run as:
##      $ source ./bash.*/init.10*
##
## * * * *//

# $SUDO_CMD apt-get -y upgrade && $SUDO_CMD apt-get -y update

# apt-transport-https is for google/k8, others. 
# $SUDO_CMD sudo apt-get install build-essential procps curl file git apt-transport-https ca-certificates 

# Boot functions

source "$_B00T_C0DE_Path/_b00t_.bashrc"

# moved to _b00t_.bashrc
# source "$_B00T_C0DE_Path/./bash.🔨/.bash_aliases"

# TODO: need to do more multiplaform. 
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
checkOS_result="$(checkOS)"
export -f checkOS
#echo "checkOS_result: $checkOS_result"


#func(){
#    echo "Username: $USER"
#    echo "    EUID: $EUID"
#}
# 🤓 "Exporting" export -f creates an env variable with the function body.
# export -f func

##* * * * * *\\
if [ "$EUID" -ne 0 ]
  then echo "👽 Please run as root, use sudo or enter root password" 
  # su "$SUDO_USER" -c 'func'
fi
##* * * * * *//

## 命令 \\
# Mìnglìng // Command   (mkdir)
function mkdir_命令() {
    args=("$@")
    dir=${args[0]}
    #dir=$1
    cmd="/bin/mkdir -p \"$dir\""
    result=$( "$cmd" )
    echo "🚀 $cmd"
    
    if [ ! -d "$dir" ] ; then 
        log_📢_记录 "👽:不支持 failed. probably requires permission!" 

        log_📢_记录 "😇.run: sudo $cmd"
        `/usr/bin/sudo $cmd`
        if [ ! -d "$dir" ] ; then 
            log_📢_记录 "👽:不支持 sudo didn't work either."
        fi
    fi
    }



#export mkdir_命令
#mkdir_命令 "$HOME/.b00t_"
#mkdir_命令 "$HOME/.b00t_/c0re"
#chmod 711 "$HOME/._00t_/c0re"
## 命令 // 


if n0ta_xfile_📁_好不好 $( expandPath "~/.local/bin/webi" ) ; then
    log_📢_记录 "🥾🕸️ install webi the web installer - (http://webinstall.dev)"
    curl -sS https://webinstall.dev/webi | bash
    export PATH="~/.local/bin:$PATH"
fi

# webi offers an alternative (but not cross platform i think)
if n0ta_xfile_📁_好不好 $( expandPath "~/.local/bin/dotenv" ) ; then
    # TODO: wtf - not https://github.com/bashup/dotenv? 
    # TODO: chezmoi - https://github.com/twpayne/chezmoi
    log_📢_记录 "🕸️.webi dotenv $cmd"
    webi dotenv@stable
fi


##* * * * * *\\
# Install Some Tooling
# 🍰 fzf - menu, file choose  https://github.com/junegunn/fzf#using-git
# 🍰 jq  - JSON config i/o    https://stedolan.github.io/jq/
# 🍰 wget- HTTP i/o 
# 🍰 curl- HTTP i/o 

if  [ ! -x "/bin/sed" ] || \
     [ ! -x "/usr/bin/fzf" ] || \
     [ ! -x "/usr/bin/jq" ] || \
     [ ! -x "/usr/bin/wget" ]  ; then
    $SUDO_CMD apt-get install -y sed fzf jq wget curl
    # curl -sS https://webinstall.dev/jq | bash
    # 
fi




if n0ta_xfile_📁_好不好 "/usr/bin/rg" ; then
    # RipGrep, needs something higher than v10 included with ubuntu
    # 🤓 https://github.com/BurntSushi/ripgrep#installation
    pwdwas=`pwd`
    tmpdir=$(mktemp -d)
    cd $tmpdir
    log_📢_记录 "😇.install ripgrep (rg) $ARCH6"
    case "$ARCH6" in
        "x86_64")
            curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
            $SUDO_CMD dpkg -i "$tmpdir/ripgrep_12.1.1_amd64.deb"
            ;;
        "armv7l")
            curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-arm-unknown-linux-gnueabihf.tar.gz
            tar -xvzf ripgrep-12.1.1-arm-unknown-linux-gnueabihf.tar.gz
            $SUDO_CMD cp -v ripgrep-12.1.1-arm-unknown-linux-gnueabihf/rg /usr/local/bin/rg
            ;;
        *)
            log_📢_记录 "😇👽.ripgrep $ARCH6 is unsupported!"
            ;;
    esac
    cd $pwdwas
    #OR .. sudo apt-get install ripgrep
fi


# bash_source_加载 
bash_source_加载  "./bash.🔨/./init.10级/batcat.sh"
bash_source_加载  "./bash.🔨/./init.10级/yq.sh"





log_📢_记录 "🥾😇.install dialog & apt-utils"
$SUDO_CMD apt-get install -y dialog apt-utils

# _b00t_ cli - "/usr/local/bin/b00t"

## 
#if [ ! -f "~./b00t" ] ; then
#    $SUDO_CMD ln -s /c0de/_b00t_/up-cli.sh /usr/local/bin/b00t
#fi

##* * * * * *//

PATHMAN_EXISTS=$(whereis -b pathman | cut -f 2 -d ':')
if [ -z "$PATHMAN_EXISTS " ] ; then
    log_📢_记录 "😇 install pathman"
    curl -sS https://webinstall.dev/pathman | bash
fi
pathman add ~/.local/bin

## Package: uni2ascii
$SUDO_CMD apt install -y uni2ascii  
#  dpkg -s uni2ascii
#Description: UTF-8 to 7-bit ASCII and vice versa converter
# This package provides conversion in both directions between UTF-8 Unicode and
# a variety of 7-bit ASCII equivalents, including HTML numeric character
# references, various escapes and hexadecimal. Such ASCII equivalents are useful
# when including Unicode text in program source, when debugging, and when
# entering text into web programs that can handle the Unicode character set but
# are not 8-bit safe.

## note: iostat & netstat are not valid packages > ubuntu 16
$SUDO_CMD apt install -y htop tcpdump iotop