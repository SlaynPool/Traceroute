#!/bin/bash 
for i in "$@"
do
	max_TTL=$(traceroute -n -I $i| tail -n 1| cut -c1-2)
	declare -a option=("-T -p 22" "-T -p 53" "-T -p 1" "-T -p 7" "-U -p 7" "-T -p 80")
	id=0
	for t in `seq 1 $max_TTL`
	do
		for opt in "${!option[@]}"
		do
			echo $opt
			traceroute -n -A -f $t -m $t ${option[opt]} $i |tail -n 1 |awk '{print $2" "$3}'
			if traceroute -n -A -f $t -m $t ${option[opt]} $i| tail -n 1 |awk '{print $2" "$3}'| grep  "* * *"
			then 
				echo "option utilisé: ${option[opt]} TTL: $t"
				if [ $opt -eq 5 ]
				then
					
					echo 'NoID'$id" ""[ASUNKNOWN]""$id" >> "$i.txt"
					id=$((id+1))
					break
				fi
			else
				#traceroute -A -n -f $t -m $t ${option[opt]} $1| tail -n 1 | cut -d " " -f 3-6 >> route.txt
				traceroute -A -n -f $t -m $t ${option[opt]} $i|tail -n 1 |awk '{print $2" "$3}'>> "$i.txt"
				break
			fi
		done
	done
done
