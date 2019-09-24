#!/bin/bash 
#obsolète
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

max_TTL=$(traceroute -n -I $1|tail -n 1| cut -c1-2)
#max_TTL=(1 2 3 4 5 6 7 8 9 10 11 12 13 14)
declare -a liste_Proto=( "-I" "-T" "-U" )
declare -a liste_Port=( 67 53 123 80 22 443)
#TEST

#TEST
for t in `seq 1 $max_TTL`
do 
	temoin=0
	proto=0
	port=0
	for proto in "${!liste_Proto[@]}" 
	do 

		#DEBUT DE LA BOUCLE POUR INCREMENTER LE PORT 

		for port in "${!liste_Port[@]}" 
		do 
			if traceroute -n ${liste_Proto[proto]} -f $t -m $t -p ${liste_Port[port]} $1| grep "*" 
			then
				#echo $port && echo ${liste_Port[port]}
				#port=$(($port+1))
				#echo ${liste_Port[port]}
				echo "proto utilisé: ${liste_Proto[proto]} Port utilisé: ${liste_Port[port]} TTL: $t"

				if  [ $port -eq 7 ]
				then 
					break
				fi
				
				
			else             #La c'est censée arrivé ici si la condition du if n'ai pas respécté 
				
				#echo "traceroute -n ${liste_Proto[proto]} -f ${max_TTL[t]} -m ${max_TTL[t]} -p ${liste_Port[port]} $1"
				echo "proto utilisé: ${liste_Proto[proto]} Port utilisé: ${liste_Port[port]} TTL: $t"
				traceroute -n ${liste_Proto[proto]} -A -f $t -m $t -p ${liste_Port[port]} $1|tail -n 1
	
				#t=$(($t+1))
				temoin=1
			
				break

			fi
		done


		
	if [ "$temoin" = "1" ]
	then

		break
	else 
		
		
		proto=$(($proto+1))
		#echo $proto && echo ${liste_Proto[proto]}
	fi
done 
done

