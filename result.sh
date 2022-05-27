#!/bin/bash

#test_sets="SPOKEN_TEST_2022_JAN28 LIBRI_SPEECH_TEST_CLEAN"

for test_set in "SPOKEN_TEST_2022_JAN28"; do

  # 1p
  echo " WER | $test_set - 1P"
  for x in exp/*/${test_set}/wer.1p; do
    wer=`grep WER $x | cut -f2 -d" "`
    echo "$wer | $x"
  done | sort -nk1

  echo ---------------------------------------------------

  # 2p
  echo " WER | $test_set - 2P"
  for x in exp/*/${test_set}/wer.2p; do
    wer=`grep WER $x | cut -f2 -d" "`
    echo "$wer | $x"
  done | sort -nk1

  echo ---------------------------------------------------

  # 3p
  echo " WER | $test_set - 3P"
  for x in exp/*/${test_set}/wer.3p; do
    wer=`grep WER $x | cut -f2 -d" "`
    echo "$wer | $x"
  done | sort -nk1

  echo ---------------------------------------------------

  # overall
  echo " WER | $test_set - all"
  for x in exp/*/${test_set}/wer; do
    wer=`grep WER $x | cut -f2 -d" "`
    echo "$wer | $x"
  done | sort -nk1

  echo
done
