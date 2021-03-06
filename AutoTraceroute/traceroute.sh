#!/bin/bash 


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

id=O
#Boucle pour faire le traceroute en direction de plusieurs machines
for i in "$@"
do
	#Methode pour recuperer le nombre de saut max
	max_TTL=$(sudo traceroute -n -I $i| tail -n 1| cut -c1-2)
	#Liste des options du traceroute, ON PEUT EN RAJOUTER A SOUHAIT
	declare -a option=("-T -p 22" "-T -p 53" "-T -p 1" "-T -p 7" "-U -p 7" "-T -p 80")
	#id=0
	#Incrementation du Time To Live, on va envoyer paquet par paquet pour venir "mourrir" precisement sur les routeurs voulu
	for t in `seq 1 $max_TTL`
	do
		#Pour chaque options defini dans la liste
		for opt in "${!option[@]}"
		do
			#echo $opt
			#On fait notre traceroute, en fonction du TTL (Defini par la 1er boucle, et des options definis par la 2eme boucle et on recupère l'addresse IP et le numero D'AS
			val=$(sudo traceroute -n -A -f $t -m $t ${option[opt]} $i |tail -n 1 |awk '{print $2" "$3}')
			echo "$val"
			#if traceroute -n -A -f $t -m $t ${option[opt]} $i| tail -n 1 |awk '{print $2}'| grep  "*"
			#Si l'on a des etoiles Syntaxe importante car si il y a * bash peux avoir la manie d'interpreter echo * au lieux de echo "*"
			if echo "$val"|awk '{print $1}'| grep "*"
			then 
				echo "option utilisé: ${option[opt]} TTL: $t"
				if [ $opt -eq 5 ]
				then
					#Si on ne trouve pas on indique le routeur par NoIDx [ASUNKNOWNx]
					echo $opt
					echo "NoID"$id" ""[ASUNKNOWN""$id""]" >> "$i.txt"
					id=$((id+1))
					break
				fi
			else
				#Si on trouve on ecrit le resultat dans le fichier de la forme "argument.txt"
				echo "$val" >> "$i.txt"
				break
			fi
		done
	done
done

#Zbeub <3

#lance la creation du graph a la fin du script.


echo "Voulez-vous crée le graph xdot ?[yes-no]"
read $ask
if echo "$ask" = "yes"
then
	for i in "$@"
	do
		arg="$arg"" ""$i.txt"
	done
	./graph2.sh $arg
else
	exit
fi
xdot map.dot



