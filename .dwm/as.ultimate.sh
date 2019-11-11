# Colour codes from dwm/config.h
clockColor="\x0B"
soundColor="\x0C"
freeSpaceColor="\x0D"
wifiColor="\x05"
batteryColor="\x06"
sensorColor="\x07"
rpmColor="\x08"
procColor="\x09"
memColor="\x0E"

#---separator
sp="$(echo -ne " ")"
sp1="$(echo -ne " | ")"
sp2="$(echo -ne "| ")"
sp3="$(echo -ne "|")"

#print_song_info() {
#  track="$(mpc current)"
#  artist="${track%%- *}"
#  title="${track##*- }"
#  [[ -n "$artist" ]] && echo -e "${color0}ê${sp}${color5}${artist}${color9}${title} ${color0}|"
#}
#
#

print_cpufreq() {

  curr_freq="$(cpupower frequency-info | grep 'frequency is' | cut -c28-34)"
  echo -ne "${color6}º${color0}${curr_freq}"

}

print_mem() {
    make_free_work="$(unalias free)"
    mem_used="$(free -m | grep 'Mem' | cut -c28-31)"
    mem_free="$(free -m | grep 'Mem' | cut -c76-79)"
    echo -ne "${memColor}${sp}Î${sp}${mem_used}M/${mem_free}M"
}


print_fan_speed() {

	fan_speed="$( sensors | grep 'fan1:' | cut -c14-17 | head -1)"
	echo -ne "${rpmColor}${sp}Ç${sp}${fan_speed}RPM"

}



print_cpu_temp() {
	cpu_temp="$( sensors | grep 'temp1:' | cut -c16-17 | head -1)"
	echo -ne "${sensorColor}${sp}ª${sp}${cpu_temp}°C"
}


print_power() {
  status="$(cat /sys/class/power_supply/AC/online)"
  battery="$(cat /sys/class/power_supply/BAT0/capacity)"
  timer="$(acpi -b | grep "Battery" | awk '{print $5}' | cut -c 1-5)"
  if [ "${status}" == 1 ]; then
    echo -ne "${batteryColor}${sp}Â${sp}ON ${battery}"
  else
    echo -ne "${batteryColor}${sp}ð${sp}${battery}%:${timer}"
  fi
}

print_wifiqual() {
  wifiessid="$(/sbin/iwconfig 2>/dev/null | grep ESSID | cut -d: -f2)"
  wifiawk="$(echo $wifiessid | awk -F',' '{gsub(/"/, "", $1); print $1}')"
  wificut="$(echo $wifiawk | cut -d' ' -f1)"
  echo -ne "${wifiColor}${sp}¤${sp}${wificut}"
}

print_hddfree() {
  hddfree="$(df -Ph /dev/sda1 | awk '$3 ~ /[0-9]+/ {print $4}')"
  echo -ne "${freeSpaceColor}${sp}¨${sp}${hddfree}"
}

print_homefree() {
	hddfree="$(df -Ph /dev/sdb1 | awk '$3 ~ /[0-9]+/ {print $4}')"
	echo -ne "${freeSpaceColor}${sp}¨${sp}${hddfree}"
}

print_volume(){
    mix=`amixer get Master | tail -1`
    vol="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    if [[ $mix == *\[off\]* ]]; then
      #red 2
      echo -e "${soundColor}${sp}í${sp} OFF"
    elif [[ $mix == *\[on\]* ]]; then
      #green 9
      echo -e "${soundColor}${sp}í${sp}${vol}% "
    else
      #yellow6
      echo -e "${soundColor}${sp}í${sp} ---"
    fi
 }


print_datetime() {
  datetime="$(date "+%a %d %b %I:%M")"
  echo -ne "${clockColor}${sp}É${sp}${datetime}"
}

while true; do

print_cpu() {
	cpu="$( top -b -d1 -n2 | grep Cpu0 | cut -c22-24 | tail -n1 )"
	echo -ne "${procColor}${sp}Ñ${sp}${cpu}%"
}

  # Pipe to status bar, not indented due to printing extra spaces/tabs
  xsetroot -name "$(print_mem)$(print_cpu)$(print_fan_speed)$(print_cpu_temp)$(print_power)$(print_wifiqual)$(print_homefree)$(print_hddfree)$(print_volume)$(print_datetime)"

  # loop stats every 1 second
  sleep 10
 done
