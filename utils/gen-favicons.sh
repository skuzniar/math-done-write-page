#!/bin/bash

#--- Set this to the location of Inkscape
INK=/Applications/Inkscape.app/Contents/MacOS/inkscape

#------------------------------------------------------------------------------
# Command line options
#------------------------------------------------------------------------------
SVG=""
OUT="."
SZS="32 180 512" 

SVG_OPT="-svg"
OUT_OPT="-output"
SZS_OPT="-sizes"

SVG_INF="'(Relative path and name of the input SVG file)'"
OUT_INF="'(Relative path of the output directory for generated icons - default is current working directory)'"
SZS_INF="'(Space delimited list of icon sizes - default is ${SZS})'"

function usage() {
echo "Usage: $0 options"
echo ""
echo "options:  [$SVG_OPT $SVG_INF]"
echo "          [$OUT_OPT $OUT_INF]"
echo "          [$SZS_OPT $SZS_INF]"
}

#------------------------------------------------------------------------------
# Gather input parameters
#------------------------------------------------------------------------------
while [ $# -gt 0 ]
do
    if [ "$1" == "$SVG_OPT" ]
    then
        SVG="$2"
        shift; shift
    elif [ "$1" == "$OUT_OPT" ]
    then
        OUT="$2"
        shift; shift
    elif [ "$1" == "$SZS_OPT" ]
    then
        SZS="$2"
        shift; shift
    else
        usage
        exit 1
    fi
done

if [[ -z "$SVG" ]] 
then
    usage
    exit 1
fi

if [[ ! -d "$OUT" ]] 
then
    echo Output directory [${OUT}] does not exist.
    exit 1
fi

BAS=`basename "$SVG" .svg`
CWD=`pwd`

#------------------------------------------------------------------------------
# Generate desired icons
#------------------------------------------------------------------------------
for siz in $SZS
do
    ${INK} -C  --export-filename="${OUT}/${BAS}-${siz}x${siz}.png"    "${CWD}/${SVG}" -w ${siz} -h ${siz}
done

