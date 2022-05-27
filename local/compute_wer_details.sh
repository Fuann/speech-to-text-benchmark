
#!/bin/bash

ref=$1
hyp=$2
utt2spk=$3
outdir=$4

if [ $# -ne 4 ]; then
    echo "Usage: $0 <ref> <hyp> <utt2spk> <outdir>"
    exit 0
fi

align-text --special-symbol="'***'" ark:$ref ark:$hyp ark,t:- | \
      local/wer_per_utt_details.pl --special-symbol "'***'" | tee $outdir/wer_per_utt.csv | \
      local/wer_per_spk_details.pl $utt2spk | sed 's/  */,/g' | sed '/raw/d' > $outdir/wer_per_spk.csv || exit 1;
