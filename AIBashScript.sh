#! /bin/bash

# Get configuration info on what models the user wants to use and an initial prompt.
read -p "How many messages do you want the AI's to have? " numberofmessages
ollama list
read -p 'What AI model do you want to use for the first bot? (e.g llama3.2:latest): ' aimodelno1
read -p 'What AI model do you want to use for the second bot? (e.g llama3.2:latest): ' aimodelno2
clear
read -p 'What do you want to prompt the first AI model with? ' aipromptno1
clear
read -p 'What do you want to prompt the second AI model with? ' aipromptno2
clear
read -p 'Give this run a unique name ' uniquename
clear


# User confirms their options.
while true; do
    echo "Messages: $numberofmessages"
    echo "AI Model 1: $aimodelno1"
    echo "AI Model 2: $aimodelno2"
    echo "AI Model 1 Prompt: $aipromptno1"
    echo "AI Model 2 Prompt: $aipromptno2"
    echo "Unique Name: $uniquename"
    read -p "Start with these settings? (y/n): " yesno
    case $yesno in
        [Yy]* ) 
            echo "Cool, let's get started."
            break
        ;;ollama run dolphin-mixtral:8x7b
        [Nn]* ) 
            echo "Ain't no thang. Let's try again later."
            exit
        ;;
        * ) echo "Answer either y or n.";;
    esac
done

echo $aipromptno2 >> "$uniquename"_one2two.txt
echo $aipromptno1 >> "$uniquename"_two2one.txt


COUNTER=0
         while [  $COUNTER -lt $numberofmessages ]; do
              ollama run $aimodelno1 <"$uniquename"_two2one.txt >"$uniquename"_one2two.txt
              ollama run $aimodelno2 <"$uniquename"_one2two.txt >"$uniquename"_two2one.txt
             let COUNTER=COUNTER+1 
         done




















