#/bin/bash
echo "digraph map{">>map.dot
oldIp="$(sudo ifconfig enp3s0 | grep inet |awk '{ print $2}'|head -n1)"
oldIp="$(echo "10.213.0.0" "[*]")" 
declare -a color=("black" "brown" "red" "orange" "yellow" "green" "blue" "purple" "grey" "white" "gold" "silver")
temoin=0
nc=0
#while read ligne 
#do 
#ip="$(echo $ligne |cut -d " " -f 1)"
#as="$(echo $ligne |cut -d " " -f 2)"
#echo -e "\""$ip"\"" "->" "\""$as"\"" ";">>map.dot 
#done< route.txt
for i in "$@"
do
	echo $1
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
		echo -e "\"""$ip""\"""[shape=box, color=${color[nc]}, fontcolor=white, style=filled ]"";">>map.dot
		temoin=1
	else
		oldIP=$ip
		ip=$ligne
	#echo $ip
	
		echo -e "\"""$oldIP""\"" "->""\"""$ip""\"""[color=purple, arrowsize=0]"  ";">>map.dot
	
	
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
