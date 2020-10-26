#! /bin/bash

## Function:
##     Generate an audio(mp3) playlist which duration is between $len_max and $len_min
##     parameter 1: audio directory
##     parameter 2: playlist name

## dependence: ffmpeg

## Knowledge Point: 
##    1. bash data structure: Hash and array
##    2. float calculation and comparsion
##    3. use `shuf -i` to generate a random list of numbers
##    4. get audio duration via `ffprobe`

len_max=1800  #30 minutes
len_min=1500  #25 minutes
try=15

if [ "$1" == "" ]; then
   dir="./oxford/."
else
   dir=$1
fi

if [ "$2" == "" ]; then
   playlist_name="playlist.m3u"
else
   playlist_name=$2
fi

############ Don't Modify Beblow ##################

sum=0
#declare a hash audio_duration
declare -A audio_duration
#declare a array audio_list
declare -a audio_list
declare -a out_list

all_files=`find $dir -name *.mp3 `

OIFS="$IFS"
IFS=$'\n'
for i in $all_files ;do
    duration=`ffprobe $i -show_format 2>&1| sed -n 's/duration=//p'`
#    sum=`bc <<< "$sum+$duration"`
    audio_duration[$i]=$duration
    audio_list+=($i)
#    echo "$i->$duration"
done
## loop key within hash
#echo "Loop hash"
#for audio in "${!audio_duration[@]}";do
#    echo "$audio-> ${audio_duration[$audio]}"
#done

#echo "Loop array"
#for i in "${!audio_list[@]}";do
#    echo "array[$i]:${audio_list[$i]} $((RANDOM%${#audio_list[@]})) "
#done

job_done=0
for tried in `seq 1 1 $try`; do
#        echo "->$sum"
    if (( $(echo "$sum < $len_min" | bc -l))); then
        entries=($(shuf -i 0-$((${#audio_list[@]}-1)) -n ${#audio_list[@]}))
        for i in "${!entries[@]}";do
            indx=${entries[$i]}
            audio_name=${audio_list[$indx]}
            audio_duration=${audio_duration[$audio_name]}
            tmp=`bc <<< "$sum+$audio_duration"`
            if (( $(echo "$tmp > $len_max" | bc -l))); then
                #echo "larger than 1800 seconds, break"
                job_done=1
                break;
            else
#                echo "random:$audio_name -> $audio_duration"
                out_list+=($audio_name)
                sum=$tmp
            fi
        done
    fi
    if (($job_done == 1));then
       break;
    fi
done

echo "" > $playlist_name
for i in "${!out_list[@]}";do
    echo "${out_list[$i]}"  >> $playlist_name
done
IFS="$OIFS"
echo $sum
