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
    echo "Error: Argument not provided. Please provide your OpenAI api key as an argument using -a <OPEN_AI_API_KEY>."
    exit 1
fi

# Your script logic here that uses the provided argument value
echo "The provided API KEY is: $key_value"

export OPENAI_API_KEY=$key_value
FILE_PATH=$file_value # Example data/global_youtube_stats.csv
TARGET=$target_value # Example "Title"
INPUT_VALUES=$input_values # Example "Channel,Category,Subscribers"

python json_parser.py $FILE_PATH outputs/output.json $INPUT_VALUES $TARGET
openai tools fine_tunes.prepare_data -f outputs/output.json
openai api fine_tunes.create -t outputs/output_prepared.jsonl  -m davinci

