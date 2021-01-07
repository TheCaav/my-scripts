#!/bin/sh

defOutputPath=test
defVoltDiff=5
defTimeout=10m

voltdiff=${1:-5}
timeout=${2:-10m}
outputPath=${3:-$defOutputPath}

echo "Voltdiff = " $voltdiff
echo "Timeout = " $timeout

function stresstest {
	sumtemps=0.0
	currsum=0.0
	cnt=0
	stress -c 8 -i 2 -m 2 -t $timeout &
	pid=$!

	while kill -0 "$pid" >/dev/null 2>&1; do
		temp=$(sensors | grep Package | sed 's/\s\s*/ /g ; s/+// ; s/°// ; s/C//' | cut -d' ' -f 4)
		current=$(sensors -u | grep curr1_input | sed 's/\s\s*/ /g' | cut -d' ' -f 3)
		
		sumtemps=$(echo "$sumtemps + $temp" | bc -l)
		currsum=$(echo "$currsum + $current" | bc -l)
		cnt=$(echo "$cnt + 1" | bc -l)
		sleep 1
	done
	
	tempAvg=$(echo "$sumtemps / $cnt" | bc -l)
	currAvg=$(echo "$currsum / $cnt" | bc -l)

	echo "Average Temperature: " $tempAvg >> $outputPath
	echo "Average Current: " $currAvg >> $outputPath
}

stress -c 8 -t 5m

echo "Start undervolting" > $outputPath

while (true) 
do
	echo "Trying voltdiff: " $voltdiff &&
	undervolt --uncore -$voltdiff &&
	undervolt --read >> $outputPath &&
	stresstest &&
	let "voltdiff = $voltdiff + 10"
done
