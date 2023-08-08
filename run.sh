while getopts ":a:f:i:t:" opt; do
    case $opt in
        a)
            key_value="$OPTARG"
            ;;
        f)
            file_value="$OPTARG"
            ;;
        i)
            input_values="$OPTARG"
            ;;
        t)
            target_value="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument. Please provide your OpenAI api key as an argument using -a <OPEN_AI_API_KEY>" >&2
            exit 1
            ;;
    esac
done

if [ -z "$key_value" ]; then
    echo "Error: Argument not provided. Please make sure you provided the OpenAI api key via the -a argument. Read Readme file for more instructions and examples."
    exit 1
fi

if [ -z "$file_value" ]; then
    echo "Error: Argument not provided. Please make sure you provided the file path via the -f argument. Read Readme file for more instructions and examples."
    exit 1
fi

if [ -z "$input_values" ]; then
    echo "Error: Argument not provided. Please make sure you provided the input values via the -i argument. Read Readme file for more instructions and examples."
    exit 1
fi

if [ -z "$target_value" ]; then
    echo "Error: Argument not provided. Please make sure you provided the target values via the -t argument. Read Readme file for more instructions and examples."
    exit 1
fi

# Your script logic here that uses the provided argument value
echo "The provided API KEY is: $key_value"

export OPENAI_API_KEY=$key_value
FILE_PATH=$file_value # Example data/global_youtube_stats.csv
TARGET=$target_value # Example "value1,value2"
INPUT_VALUES=$input_values # Example "value1,value2,value3"

set -e # Exit script immediately on first error.

python json_parser.py $FILE_PATH outputs/output.json $INPUT_VALUES $TARGET

openai tools fine_tunes.prepare_data -f outputs/output.json
openai api fine_tunes.create -t outputs/output_prepared.jsonl  -m davinci

