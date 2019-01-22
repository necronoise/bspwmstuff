#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

### alias & binds

umask 0077 #toda vez que o terminal cria um arquivo o arquivo so vai ter permissao de leitura escrita so pro usuario

bind "\C-l":clear-screen
alias ls='ls --color=auto'
alias remove='sudo xbps-remove'
alias search='xbps-query -Rs'
alias install='sudo xbps-install'
alias update='sudo xbps-install -Suvy'
alias rns='sudo xbps-remove -o'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias shutdown='sudo shutdown -h now'
alias zzz='sudo zzz'
alias instsrc='sudo xbps-install --repository=hostdir/binpkgs'
alias ".."='cd ..'
#alias rsn='sudo pacman -Rsn $(pacman -Qdtq)'
#alias search='pacman -Ss '
#alias update='sudo pacman -Syyuu'
#alias install='sudo pacman -S '
#alias remove='sudo pacman -R '
#alias shutdown='shutdown -h now'
#alias yinstall='yay -S '
#alias ysearch='yay -Ss '
#alias yupdate='yay -Syyuu'
alias ytb='mpv --ytdl-format=22 $1'
alias ytm='mpv --ytdl-format=18 $1'
#alias xcp='xclip -selection clipboard'
#alias nt='notify-send'

yopus() {
        youtube-dl "$@" --add-metadata --metadata-from-title "%(artist)s - %(title)s" \
        --extract-audio --prefer-ffmpeg --youtube-skip-dash-manifest --ignore-errors
}

ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

wget-extension() {
  if [ $# -lt 2 ]; then
    echo -e "Download all files with specific extension on a webpage"
    echo -e "\nUsage: wget-extension <file_extension> <url>"
    echo -e "\nExample:\nwget-extension mp4 http://example.com/files/"
    echo -e "wget-extension mp3,ogg,wma http://samples.com/files/"
    return 1
  fi

  # savepath=~/Downloads
  # outputdir_name=$(echo "$2" | rev | cut -d\/ -f2 | rev)
  # mkdir -pv "$savepath/$outputdir_name"
  # cd "$savepath/$outputdir_name" && wget -r -l1 -H -t1 -nd -N -np -A "$1" -erobots=off "$2"

  outputdir_name=$(echo "$2" | rev | cut -d\/ -f2 | rev)
  mkdir -pv "$outputdir_name"
  cd "$outputdir_name" && wget -r -l1 -H -t1 -nd -N -np -A "$1" -erobots=off "$2"
}


### terminal indicator

#PS1='[\u@\h \W]\$ '
PS1='\[\033[01;37m\]\W\[\033[01;32m\] - \[\033[00m\]'

PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/sun/.myscripts

export PANEL_FIFO="/tmp/panel-fifo"
