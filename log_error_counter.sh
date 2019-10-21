#!/bin/bash

declare -A errorList=(
    ['error01']='bla bla bla error'
    ['error02']='media failed error blabla'
    ['error03']='Found error at disk, ev_id="EV_ID", dev_s="QUANT_D"'
    ['error04']='optic error'
)

checkName="error_catcher_counter"
pathLogs="/home/logs_test/"
logFileName="foo.log.*"
dateLog="10-10-2019"

warnLimit=1000
critLimit=2000

statusData=0
outputTxt=""

totalCount=0

pathGrepedFile="${pathLogs}grepedByDate.txt"
declare -A countErr=()
#--------------------------------------------------------------------------------------------------------#

fgrep "$dateLog" ${pathLogs}${logFileName} > ${pathGrepedFile}

for i in "${!errorList[@]}"
do
    errorCount=$(fgrep -c "${errorList[$i]}" ${pathGrepedFile})
	outputTxt+="${errorCount} ${i}, "
    let totalCount=totalCount+errorCount
done

performData="error_count=${totalCount};${warnLimit};${critLimit}"

echo "${statusData} ${checkName} ${performData} ${outputTxt}"
