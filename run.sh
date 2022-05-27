#!/bin/bash

# [ Credentials ]
AZURE_SPEECH_KEY=
AZURE_SPEECH_LOCATION=
AWS_PROFILE=
GOOGLE_APPLICATION_CREDENTIALS=

# [ Datasets ]
DATASET=SPOKEN_TEST_2022_JAN28
DATASET_FOLDER="data/spoken_test_2022_jan28/input.txt"
test1p=data/spoken_test_2022_jan28/text.1p
test2p=data/spoken_test_2022_jan28/text.2p
test3p=data/spoken_test_2022_jan28/text.3p

# [ Engines ]
engines="AZURE_SPEECH_TO_TEXT AMAZON_TRANSCRIBE GOOGLE_SPEECH_TO_TEXT_ENHANCED GOOGLE_SPEECH_TO_TEXT"

# [ Others ]
tag=""
_opts=""


for engine in $engines; do

    if [ "$engine" == "AZURE_SPEECH_TO_TEXT" ]; then
        tag="azure"
        _opts="--azure-speech-key ${AZURE_SPEECH_KEY} "
        _opts+="--azure-speech-location ${AZURE_SPEECH_LOCATION}"
    elif [ "$engine" == "AMAZON_TRANSCRIBE" ]; then
        tag="aws"
        _opts="--aws-profile ${AWS_PROFILE}"
    else
        [ "$engine" == "GOOGLE_SPEECH_TO_TEXT_ENHANCED" ] && tag="google_enhanced"
        [ "$engine" == "GOOGLE_SPEECH_TO_TEXT" ] && tag="google_standard"
        _opts="--google-application-credentials ${GOOGLE_APPLICATION_CREDENTIALS}"
    fi

    OUTPUT_FOLDER=exp/$tag
    mkdir -p exp/$tag

    echo "$0: Decoding ${DATASET} with $engine ..."
    python3 benchmark.py \
        --dataset ${DATASET} \
        --dataset-folder ${DATASET_FOLDER} \
        --output-folder ${OUTPUT_FOLDER}  \
        --engine $engine \
        ${_opts}

    local/compute_individual_wer.sh $OUTPUT_FOLDER/SPOKEN_TEST_2022_JAN28 $text1p $text2p $text3p

done

./result.sh

exit 0
