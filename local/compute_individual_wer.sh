#!/bin/bash

data=$1
text1p=$2
text2p=$3
text3p=$4

if [ $# -ne 4 ]; then
    echo "Usage: $0 exp/azure/SPOKEN_TEST_2022_JAN28 text.1p text.2p text.3p"
    exit 0
fi

# sorting
sort $data/hyp > $data/temp
mv $data/temp $data/hyp

# split
local/filter_scp.pl -f 1 $text1p $data/hyp > $data/hyp.1p
local/filter_scp.pl -f 1 $text2p $data/hyp > $data/hyp.2p
local/filter_scp.pl -f 1 $text3p $data/hyp > $data/hyp.3p

# compute-wer
compute-wer ark:$text1p ark:$data/hyp.1p | grep WER > $data/wer.1p
compute-wer ark:$text2p ark:$data/hyp.2p | grep WER > $data/wer.2p
compute-wer ark:$text3p ark:$data/hyp.3p | grep WER > $data/wer.3p

