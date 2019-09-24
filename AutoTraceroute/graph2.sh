#/bin/bash
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
                       
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.

echo "digraph map{">>map.dot
oldIp="$(sudo ifconfig enp3s0 | grep inet |awk '{ print $2}'|head -n1)"
oldIp="$(echo "$oldIp" "[*]")" 
declare -a color=("black" "brown" "red" "orange" "yellow" "green" "blue" "purple" "grey" "white" "gold" "silver")
temoin=0
nc=0
#############Pour Lier Les addresses a leurs AS###############################
#while read ligne 
#do 
#ip="$(echo $ligne |cut -d " " -f 1)"
#as="$(echo $ligne |cut -d " " -f 2)"
#echo -e "\""$ip"\"" "->" "\""$as"\"" ";">>map.dot 
#done< route.txt
############################################################################## 
for i in "$@"
do
	echo -e "\"""$i""\"""[label="\""$i"\"", fontcolor=white, color=${color[nc]}, style=filled]">>map.dot
	
	while read ligne
	do 
#Premier Ligne
	if [ $temoin -eq 0 ]
	then 
		ip=$ligne
		echo $ligne
		echo $ip
		echo -e "\"""$oldIp""\"""->""\"""$ip""\"""[color=purple arrowsize=0]"  ";" >>map.dot 
		echo -e "\"""$oldIp""\"""[shape=box, color=${color[nc]}, fontcolor=white, style=filled]"";">>map.dot
		echo -e "\"""$ip""\"""[shape=box, color=${color[nc]}, fontcolor=white, style=filled]"";">>map.dot
		temoin=1
	else
		oldIP=$ip
		ip=$ligne
	#echo $ip
	
		echo -e "\"""$oldIP""\"" "->""\"""$ip""\"""[color=purple, arrowsize=0]"";">>map.dot
	
	
	#echo -e "\"""$oldIP""\"""-> ""\"""$ip""\"""[color=purple, arrowsize=0]"";"
		echo -e "\"""$ip""\"""[shape=box, color=${color[nc]}, fontcolor=white, style=filled]"";">>map.dot
	fi
	done< $i
	nc=$((nc+1))
	oldIp="$(sudo ifconfig enp3s0 | grep inet |awk '{ print $2}'|head -n1)"
	oldIp="$(echo "$oldIp" "[*]")" 
	temoin=0
done






echo "}">> map.dot
