
# Kaggle datasets
global_youtube_stats.csv - All rights to https://www.kaggle.com/datasets/nelgiriyewithana/global-youtube-statistics-2023

NVDA.csv - All rights to https://www.kaggle.com/datasets/bilalwaseer/nvidia-stocks-historical-data

cars_2023.csv - All rights to https://www.kaggle.com/datasets/anoopjohny/2023-cars-dataset 



# Make the script executable

This command wil make the do.sh script an executable file:
<pre>
chmod +x do.sh
</pre>

# Execute the script

This command will execute the executable file:

<pre>
./do.sh -a OPEN_AI_API_KEY> -f DATA_PATH
</pre>

Here you have an example:

-a = open ai Api key
-f = File
-t = Target variables
-i = Input variables

<pre>
./do.sh -a sk-your_key -f data/global_youtube_stats.csv -t Title,Uploads -i channel_type,Category,Subscribers
</pre>

As you can see, this has a problem: the data requires a preprocessing if you have some attributes which names contains blank spaces. For example, in the demo dataset "global_youtube_stats.csv" you can check there is an attribute which name is "video views", if we wanted to work with it, we would need to change it's name to "video_views". Please, take this into account.

I strongly recommend to save the data file (which should mandatory be a csv file) in the data folder. In the path you should add the complete route. Example: data/global_youtube.stats.csv

Here you have another example:
<pre>
./do.sh -a sk-your_key -f data/NVDA.csv -t Volume -i Date,Open,High,Low,Close
</pre>


This will generate in the "outputs" folder a new json file. After that, we will see in the console the following output: 

<pre>
"Analyzing...

- Your file contains 995 prompt-completion pairs
- All prompts end with suffix `00000`
- All prompts start with prefix `Channel: `
- All completions start with prefix `Title: `. Most of the time you should only add the output data into the completion, without any prefix
- Your data does not contain a common ending at the end of your completions. Having a common ending string appended to the end of the completion makes it clearer to the fine-tuned model where the completion should end. See https://platform.openai.com/docs/guides/fine-tuning/preparing-your-dataset for more detail and examples.
- The completion should start with a whitespace character (` `). This tends to produce better results due to the tokenization we use. See https://platform.openai.com/docs/guides/fine-tuning/preparing-your-dataset for more details

Based on the analysis we will perform the following actions:
- [Recommended] Remove prefix `Title: ` from all completions [Y/n]: "

</pre>


We will press "ENTER" key to this recommendation and also for the following.

After this, a new file will be generated in the output folder with name output_prepared.jsonl.

Let the script finish the execution. The stream could be automatically cancelled, but this doesn't mean the task was cancelled.

As the output of the script says:
<pre>
(Ctrl-C will interrupt the stream, but not cancel the fine-tune)
[2023-08-08 12:26:24] Created fine-tune: ft-kYDR9jmAxHZdRevQ5CSUFOcq

Stream interrupted (client disconnected).
To resume the stream, run:

  openai api fine_tunes.follow -i ft-kYDR9jmAxHZdRevQ5CSUFOcq
</pre>

You are given the command to follow the task. This might take a while.