#!/bin/bash

source "/c0de/_b00t_/_b00t_.bashrc"
# this might need to move to python. 

if [ ! -x "/usr/local/bin/b00t.sh" ] ; then
  # setup symlink for faster access
  $SUDO_CMD ln -s /c0de/_b00t_/_b00t_.sh /usr/local/bin/b00t.sh
fi 

# 问问题 wèntí - ask question. 
# if you want to disable specific features then change to 没有
cat >/dev/shm/_b00t_.yaml <<🏁
---
  _b00t_w41137_3RC20: "问题"
  _b00t_azur3: "问题"
🏁

# cat /dev/shm/_b00t_.yaml | yq | jq --arg a xyz '.bar=$a
while read -rd $'' line
do
    export "$line"
done < <(jq -r <<<"$values" \
         'to_entries|map("\(.key)=\(.value)\u0000")[]')

# convert yaml config to environment variables
# 🍰 https://stackoverflow.com/questions/48512914/exporting-json-to-environment-variables
export $(echo $values | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]")


# export $(cat /dev/shm/_b00t_.yaml | yq | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]")


echo $_b00t_w41137_3RC20
exit


## setup environment-vars
_b00t_W41137=$( crudini_get "b00t" "W41137_3RC20" )
if [ -z "$_b00t_W41137" ] ; then
  log_📢_记录 "🥯🙀 no erc20 wallet!, please provide 0x.... or enter to skip crypto"
  read _b00t_W41137
  if [ -n "$_b00t_W41137" ] ; then
      log_📢_记录 "🥯👽 no wallet set!"
      crudini_set "b00t" "W41137_3RC20" "没有"
  else 
      log_📢_记录 "🥯🥰 .env _b00t_W41137: $_b00t_W41137_3RC20"
      crudini_set "b00t" "W41137_3RC20" "$_b00t_W41137_3RC20"
  fi
fi 




## * * * * \\
# Get filename and --parameters
filename=$1
while getopts ":g:i:n:m:e:" arg; do
  case $arg in
    g) resourceGroup=$OPTARG;;
    i) ID=$OPTARG;;
    n) Name=$OPTARG;;
    m) Manufacturing_date=$OPTARG;;
    e) Expire_date=$OPTARG;;
  esac
done
echo -e "\n$ID $Name\n"
# ./bash-cmd.新.sh -g -i p001 -n 'Hot Cake' -m '01-01-2018' -e '06-01-2018'
## * * * * //


## make a cifs share
#docker volume create \
#	--driver local \
#	--opt type=cifs \
#	--opt device=//uxxxxx.your-server.de/backup \
#	--opt o=addr=uxxxxx.your-server.de,username=uxxxxxxx,password=*****,file_mode=0777,dir_mode=0777 \
#	--name cif-volume

  
