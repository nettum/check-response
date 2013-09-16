#!/bin/bash
 
if [ $# -ne 2 ]
then
    printf "\nUsage:\n"
    printf "./check_response.sh <url> <num_requests>\n"
    printf "\"./check_response.sh http://www.reddit.com/ 10\" would test the response form reddit 10 times and calculate avg response\n\n"
    exit
fi
 
#Ensure that decimal point character is . so bc won't brake
export LC_ALL='en_US.UTF-8'
 
curl="/usr/bin/curl"
url=$1
num_requests=$2
count=1
total_lookup=0
total_connect=0
total_pre=0
total_start=0
total_time=0

 
printf "\n\nLookup\tConnect\tPreXfer\tStartXfer\tTotal\n\n";
while [ $count -le "$num_requests" ]
do

    result=`$curl -w '%{time_namelookup}:%{time_connect}:%{time_pretransfer}:%{time_starttransfer}:%{time_total}' -o /dev/null -s $url`

    vars=$(echo $result | awk -F ":" '{print $1, $2, $3, $4, $5}')
    set -- $vars

    printf "$1\t$2\t$3\t$4\t\t$5 \n"

    total_lookup=`echo "scale=3; $total_lookup + $1"  | bc`;
    total_connect=`echo "scale=3; $total_connect + $2"  | bc`;
    total_pre=`echo "scale=3; $total_pre + $3"  | bc`;
    total_start=`echo "scale=3; $total_start + $4" | bc`;
    total_time=`echo "scale=3; $total_time + $5" | bc`;

    count=$((count+1))

done

printf "\n\nAverage:\n\n"
printf "`echo "scale=3; $total_lookup/$num_requests" | bc | sed 's/^\./0./'`\t`echo "scale=3; $total_connect/$num_requests" | bc | sed 's/^\./0./'`\t`echo "scale=3; $total_pre/$num_requests" | bc | sed 's/^\./0./'`\t`echo "scale=3; $total_start/$num_requests" | bc | sed 's/^\./0./'`\t\t`echo "scale=3; $total_time/$num_requests" | bc | sed 's/^\./0./'`\n\n"