#!/bin/bash

# librispeech test-clean
#DATASET=LIBRI_SPEECH_TEST_CLEAN
#DATASET_FOLDER="data/test-clean"

# spoken_test_2022_jan28
DATASET=SPOKEN_TEST_2022_JAN28
DATASET_FOLDER="data/spoken_test_2022_jan28/input.txt"
test1p=data/spoken_test_2022_jan28/text.1p
test2p=data/spoken_test_2022_jan28/text.2p
test3p=data/spoken_test_2022_jan28/text.3p

# test
#DATASET_FOLDER="test.txt"


# --------- azure

#mkdir -p exp/azure
#AZURE_SPEECH_KEY=ecb69acebd244777b333f83a26d68dbd
#AZURE_SPEECH_LOCATION=westus2
#python3 benchmark.py \
#    --dataset ${DATASET} \
#    --dataset-folder ${DATASET_FOLDER} \
#    --output-folder exp/azure  \
#    --engine AZURE_SPEECH_TO_TEXT \
#    --azure-speech-key ${AZURE_SPEECH_KEY} \
#    --azure-speech-location ${AZURE_SPEECH_LOCATION}

#local/compute_individual_wer.sh exp/azure/${DATASET} $test1p $test2p $test3p

# --------- aws

#mkdir -p exp/aws
#AWS_PROFILE="default"
#python3 benchmark.py \
#    --dataset ${DATASET} \
#    --dataset-folder ${DATASET_FOLDER} \
#    --output-folder exp/aws \
#    --engine AMAZON_TRANSCRIBE \
#    --aws-profile ${AWS_PROFILE}

#local/compute_individual_wer.sh exp/aws/${DATASET} $test1p $test2p $test3p

# --------- google enhanced

mkdir -p exp/google_enhanced
GOOGLE_APPLICATION_CREDENTIALS=others/google-credential.json
python3 benchmark.py \
    --dataset ${DATASET} \
    --dataset-folder ${DATASET_FOLDER} \
    --output-folder exp/google_enhanced \
    --engine GOOGLE_SPEECH_TO_TEXT_ENHANCED \
    --google-application-credentials ${GOOGLE_APPLICATION_CREDENTIALS}

local/compute_individual_wer.sh exp/google_enhanced/${DATASET} $test1p $test2p $test3p

# --------- google standard

#mkdir -p exp/google_standard
#GOOGLE_APPLICATION_CREDENTIALS=others/google-credential.json
#python3 benchmark.py \
#    --dataset ${DATASET} \
#    --dataset-folder ${DATASET_FOLDER} \
#    --output-folder exp/google_standard \
#    --engine GOOGLE_SPEECH_TO_TEXT \
#    --google-application-credentials ${GOOGLE_APPLICATION_CREDENTIALS}

#local/compute_individual_wer.sh exp/google_standard/${DATASET} $test1p $test2p $test3p

# --------- result
./result.sh
