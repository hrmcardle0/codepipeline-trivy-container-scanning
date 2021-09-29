#!/bin/bash
high=0;
medium=0;
low=0;
sev=$(cat output.json | jq ._1[0].Vulnerabilities[].Severity | sed 's/"//g') 2> /dev/null

for a in $sev;
do
	 if [[ "$a" == *"HIGH"* ]]; then
		 high=$((high+1));
	 elif [[ "$a" == *"MEDIUM"* ]]; then
		 medium=$((medium+1));
	 else
		 low=$((low+1))
	 fi
done
echo -e "HIGH\tMEDIUM\tLOW\n"
echo -e "$high\t$medium\t$low\n"
