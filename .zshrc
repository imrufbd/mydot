#EXPORT 
export TERM="xterm-256color"
export TERM="st-256color"
export ZSH="/home/masud/.oh-my-zsh"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=dbus
export QT_IM_MODULE=ibus

#PLUGINS
plugins=(git extract zsh-autosuggestions zsh-syntax-highlighting zsh-completions vi-mode)

#SOURCE
source $ZSH/oh-my-zsh.sh
source /home/masud/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
#source /home/masud/powerlevel10k/powerlevel10k.zsh-theme

#Theme
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME=powerlevel10k/powerlevel10k
#ZSH_THEME=robbyrussell

#Files
#LIST
alias ls='ls --color=auto --group-directories-first'
alias lsa='ls -lah --color=auto --group-directories-first'
#alias la='ls -a --color=auto'
#alias lah='ls -lah --color=auto'
#alias l='ls' 					
#alias l.="ls -A | egrep '^\.'"      

alias cp="cp -v"
alias mv="mv -iv"
alias rm="rm -v"
alias mkd="mkdir -pv"

#TYPO
alias cd..='cd ..'
alias pdw="pwd"

#GREP
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#diff
alias diff="diff --color=auto" \

#FREE
alias free="free -mt"

#USERLIST
alias userlist="cut -d: -f1 /etc/passwd"

#MERGE
alias merge="xrdb -merge ~/.Xresources"

#OUTPUT
alias df='df -h'

#CONKY
alias kc='killall conky'

#HARDWARE
alias hw="hwinfo --short"

#MICROCODE
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#GRUB
#alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#DATABASE/Search #fzf
alias updb='sudo updatedb'
alias e='fzf_file'
alias f='fzf_cd'
alias k='fzf_kill'
alias h='fzf_history'


fzf_file() { zle -I; FILE=$(find ${1:-.} -type f -print 2> /dev/null | fzf +m) && vim "$FILE" ; }; zle -N fzf_file;

# fzf_config() { zle -I; du -a ~/.scripts/* ~/.config/* | awk '{print $2}' | fzf | xargs -r $EDITOR }; zle -N fzf_config; bindkey '^E' fzf_config

fzf_history() { zle -I; eval $(history | fzf -e +i +s | sed 's/ *[0-9]* *//') ; }; zle -N fzf_history; bindkey '^H' fzf_history

fzf_kill() { zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; zle -N fzf_kill; bindkey '^K' fzf_kill

fzf_cd() { zle -I; DIR=$(find ${1:-.} -type d -print 2> /dev/null | fzf +m) && cd "$DIR" ; }; zle -N fzf_cd; bindkey '^F' fzf_cd

# ffd() { zle -I; DIR=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && cd "$DIR" ; }; zle -N ffd; bindkey '^F' ffd

#FONTS
alias fc='sudo fc-cache -fv'

#WGET
alias wget="wget -c"

#MIRROR
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
alias mirrorb="sudo reflector -f 10 --country Bangladesh --save /etc/pacman.d/mirrorlist"

#PACMAN
alias pac='sudo pacman --color auto'
alias update='sudo pacman -Syyu'
alias up='sudo pacman -Syu'
alias pacs='pacman -Ss'
alias inp='sudo pacman -S'
alias rmv='sudo pacman -Rns'

alias unlock="sudo rm /var/lib/pacman/db.lck"
alias armv='sudo pacman -Rns $(pacman -Qtdq)'
alias cc='sudo pacman -Sc'
alias nrp='pacman -Qdt'
alias lfp='pacman -Qqm'
alias fp='pacman -Qm'
alias efp='pacman -Qqe'

alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -100"

#AUR
alias inpkg='makepkg -si'
alias upaur="yay -Syu"

#yay
alias yinp='yay -S'
alias yayskip='yay -S --mflags --skipinteg'
alias upyay="yay -Syu --noconfirm"
#trizen
alias tinp='trizen -S'
alias uptrizen="trizen -Syu --noconfirm"
alias trizenskip='trizen -S --skipinteg'

#XBPS
#alias up='sudo xbps-install -Su'
#alias pacs='xbps-query -Rs'
#alias inp='sudo xbps-install -Su'
#alias rmv='sudo xbps-remove -R'
#alias armv='sudo xbps-remove -o'
#alias ccache='sudo pacman -O'

#wpa_supplicant
#alias wpa='sudo wpa_supplicant -B -i wlp4s0 -c /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf && sudo dhcpcd wlp4s0'

#MOUNT
alias mount='udisksctl mount -b'
alias usb='udisksctl mount -b /dev/sdb1'
alias uusb='udisksctl unmount -b /dev/sdb1'
alias eusb='udisksctl power-off -b /dev/sdb1'
alias sdx='mountjutsu'

#youtube-dl
alias ytd-aac="youtube-dl --extract-audio --audio-format aac "
alias ytd-best="youtube-dl --extract-audio --audio-format best "
alias ytd-flac="youtube-dl --extract-audio --audio-format flac "
alias ytd-m4a="youtube-dl --extract-audio --audio-format m4a "
alias ytd-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias ytd-opus="youtube-dl --extract-audio --audio-format opus "
alias ytd-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias ytd-wav="youtube-dl --extract-audio --audio-format wav "
alias ytd-best="youtube-dl -f bestvideo+bestaudio "
alias ytd='youtube-dl'
alias ytdF='youtube-dl -F'
alias ytdf='youtube-dl -f'
alias ytv='youtube-viewer -C'

#MAIL
#alias newmail='mailsync'
alias mail='mailsync && neomutt'

#TRANSMISSION

alias pfx='peerflix -k -f /home/masud/Videos/ptfx'
alias tfx='torrentflix'

tsmcc() {
        transmission-remote -l | grep 100% | grep Done | \
        awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % -r ;} #clearcompleted
tsm() { transmission-remote --list ;}
        # numbers of ip being blocked by the blocklist
        # credit: smw from irc #transmission-status
tsmcnt() { echo "Blocklist rules:" $(curl -s --data \
        '{"method": "session-get"}' localhost:9091/transmission/rpc -H \
        "$(curl -s -D - localhost:9091/transmission/rpc | grep X-Transmission-Session-Id)" \
        | cut -d: -f 11 | cut -d, -f1) ;} #tsm-count
tsmbl() { $PATH_SCRIPTS/blocklist.sh ;}         # update blocklist
tsmdmn() { transmission-daemon ;} #tsm-daemon
tsmquit() { killall transmission-daemon ;} #killtsm
tsmaspd() { transmission-remote --alt-speed ;}       # limit bandwidth
tsmnaspd() { transmission-remote --no-alt-speed ;}   # dont limit bandwidth
tsmadd() { transmission-remote --add "$1" ;} #add torrent
tsmaskp() { transmission-remote -t"$1" --reannounce ;} #ask more peers
tsmstop() { transmission-remote -t"$1" --stop ;}              # stop <id> or all 
tsmstart() { transmission-remote -t"$1" --start ;}             # start <id> or all
tsmpurge() { transmission-remote -t"$1" --remove-and-delete ;} # delete data also
tsmdel() { transmission-remote -t"$1" --remove ;}           # leaves data alone
tsminfo() { transmission-remote -t"$1" --info ;} #info
tsmspeed() { while true;do clear; transmission-remote -t"$1" -i | grep Speed;sleep 1;done ;}

#MIS
alias sys='sudo systemctl'
#alias sys='sudo sv'
alias vol='ncpamixer'
alias def='sdcv'
alias radio='curseradio'
alias music='ncmpcpp'
alias sv='sudo vim'
alias rit='rtv'
alias keep='keepcli'
alias drive='gdrive'
alias books='pysheng'
alias imgur='imgur_downloader'
alias weather='curl wttr.in/khagrachari'
alias e.g='tldr'
alias tweet='turses'
alias pdf='zathura'
alias img='sxiv'
alias calc='sc-im'
alias el='elinks'
alias ka='killall'
#alias ibus='ibus-daemon -xdr'

alias vim='nvim'

#alias wp='QuickWall --setter feh'
#alias wp='splash'

#GIT
alias gitc='git clone'
alias gitu='git push -u origin master'
alias gitca='git commit -a'
alias gita='git add'
alias gits='git status'

#ARCHIVE
alias uz='atool -x'
alias zip='atool -a'

#SURFRAW
alias srs='sr startpage'
alias srb='sr bing'
alias srd='sr duckduckgo'
alias srg='sr google'
alias srv='sr youtube'
alias sry='sr yahoo'
alias sraw='sr archwiki'
alias sraur='sr aur'
alias srpkg='sr archpkg'
alias srmdb='sr imdb'
alias srgit='sr github'
alias sru='sr urban'
alias srpb='sr piratebay'

#torsocks
alias tor='sys start tor.service'
alias tors='sys stop tor.service'
alias ctorc='torsocks elinks 'https://check.torproject.org/''
#alias ctorb='torsocks surf https://check.torproject.org/'

#IP/PING
alias pnet='ping -c 3 google.com'
alias myip='ip addr show'
alias ip-isp='curl ifconfig.co'
#curl ifconfig.co/json
#http -b ifconfig.co
#wget -qO- ifconfig.co
#fetch -qo- https://ifconfig.co
#bat -print=b ifconfig.co/ip
#curl ifconfig.co/country
#curl ifconfig.co/country-iso
#curl ifconfig.co/city
#curl ifconfig.co/asn

#SSH
alias fst='sudo systemctl start sshd'
alias fsts='sudo systemctl stop sshd'
#alias termux='ssh -p 8022 u0_a127@192.168.137.234'

#PNGLatex
#pnglatex -h for help
alias eq='pnglatex -b Transparent -d 300 -s 12'

#JavaWM
alias jwc='wmname LG3D'

#DE/WM
alias gui='startx'
alias dwm='cp .xinit/dwm.xinitrc .xinitrc && gui'
alias i3='cp .xinit/i3.xinitrc .xinitrc && gui'
alias xfce='cp .xinit/xfce.xinitrc .xinitrc && gui'
alias xmonad='cp .xinit/xmonad.xinitrc .xinitrc && gui'

#POWERMANAGEMENT
#alias iph='i3exit suspend'
#alias ipl='i3exit lock'
#alias ips='i3exit shutdown'
#alias ipr='i3exit reboot'
#alias bat="cat /sys/class/power_supply/BAT?/capacity" \

alias q='exit'

#Bind
#bindkey -v

#FETCH
alias inf='pfetch'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

source /home/masud/.config/broot/launcher/bash/br
