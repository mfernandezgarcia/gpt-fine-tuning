while getopts ":a:" opt; do
    case $opt in
        a)
            argument_value="$OPTARG"
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

if [ -z "$argument_value" ]; then
    echo "Error: Argument not provided. Please provide your OpenAI api key as an argument using -a <OPEN_AI_API_KEY>."
    exit 1
fi

# Your script logic here that uses the provided argument value
echo "The provided API KEY is: $argument_value"

export OPENAI_API_KEY=$argument_value

python json_parser.py data/global_youtube_stats.csv outputs/output.json
openai tools fine_tunes.prepare_data -f outputs/output.json
openai api fine_tunes.create -t outputs/output_prepared.jsonl  -m davinci

