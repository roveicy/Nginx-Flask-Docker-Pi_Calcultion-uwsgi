#!/bin/bash

echo "**** Settings ****"
echo "" 
echo "URL:    $TEST_URL"
echo "Sleep:  $TEST_SLEEP"
echo "Period: $TEST_PERIOD"
echo ""

echo "Users, Avg.Throughput, Errors, Avg.Response Time, 90% Response Time, Avg.Bandwidth" > results.csv

cat users.list | while read users
do
    sleep $TEST_SLEEP

    echo "**** Test $users Users ****"
    echo ""

    logs=`/usr/bin/ab -t $TEST_PERIOD -c $users -k -H "Accept-Encoding: gzip, deflate" $TEST_URL`
    echo "${logs}"
    echo ""

    rps=`echo "${logs}" | grep -o "Requests per second:.*" | grep -o "[0-9\.]*"`
    reqs=`echo "${logs}" | grep -o "Complete requests:.*" | grep -o "[0-9]*"`
    ereqs=`echo "${logs}" | grep -o "Failed requests:.*" | grep -o "[0-9]*"`
    lavg=`echo "${logs}" | grep -o "Time per request:.*" | grep -v "concurrent" | grep -o "[0-9\.]*"`
    l90=`echo "${logs}" | grep -o "90%.*" | awk '{print $2}'`
    tr=`echo "${logs}" | grep -o "Transfer rate:.*" | grep -o "[0-9\.]*"`
   
    errrate=`echo "scale=2;$ereqs/$reqs*100" | bc`
    printf "%5d, %14.2f, %5.2f%%, %17.2f, %17.2f, %13.2f\n" $users $rps $errrate $lavg $l90 $tr >> results.csv
done | tee run.log

echo "**** Summary Results ****"
echo ""
cat results.csv
echo ""
