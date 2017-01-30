#!/bin/bash
while [[ $# -ge 1 ]]
do
key="$1"
case $key in 
  -t|--type)
    OUT_TYPE="$2"
    shift
    ;;
  -f|--file)
    FILE=$2
    shift
    ;;
  --default)
    VALID=0
    echo ERROR: not a valid input 1>&2
    exit 1
    ;;
  *)
    ;;
esac
shift
done

[[ -z "${OUT_TYPE}" ]] \
&& echo ERROR: need a valid output type 1>&2 \
&& exit 1
    
[[ ! -f "${FILE}" ]] \
&& echo ERROR: need a valid file 1>&2 \
&& exit 1
# $1:event 
# $2:time
# $3 from
# $4 to
# $6 pkgSize
# $8 fid(1 is TCP)

if [ ${OUT_TYPE} = "t" ]; then
  awk '{if($1=="r" && $3=="2" && $4=="3" && $8=="1") totalPkgSize = totalPkgSize + $6 } END {printf "%f\n", totalPkgSize*8/((5-1)*1000000)}' ${FILE}

fi


