#!/bin/sh
dir=$(cd "$(dirname "$0")"; pwd);
serverlist="$dir/serverlist";


if [ ! -f $serverlist ]; then
	echo "File $serverlist doesn't exist"; 
	exit;
fi;

mailBody='';

#times of checking for avoiding the misinformation
time=6;

#times of checking flags
tmpHOST="";
tmpPORT="";
count=0;

check()
{
	HOST=$1;
	PORT=$2;
	
	if [ "$tmpHOST" = "$HOST" ] && [ "$tmpPORT" = "$PORT" ]
	then
		count=$((++count));
	else
		count=1;
		tmpHOST="$HOST";	
		tmpPORT="$PORT";	
	fi
	
	check_tcp -H $HOST -p $PORT;

	if [ $? != 0 ]
	then 
		if [ $count -le $time ]
		then
			check $HOST $PORT;
		else
			mailBody="$HOST:$PORT checked unsuccessfully \n $mailBody";
		fi
	fi
}

sendMail()
{
	if [ "$mailBody" = "" ]; then exit; fi;
	
	maillist="$dir/maillist";
	
	if [ ! -f $maillist ]; then
        	echo "File $maillist doesn't exist";
        	exit;
	fi;

	for mail in `cat $maillist`;do
		echo -ne  $mailBody|mail -s "sorry" $mail;
	done
}


for line in `cat $serverlist`;do
	host=`echo $line|awk -F ":" '{print $1}'`;
	port=`echo $line|awk -F ":" '{print $2}'`;
	check $host $port;
done
sendMail;

