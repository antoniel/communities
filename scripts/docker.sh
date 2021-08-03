#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("bash" "logs" "kill" "reset" "compose" "quit")
select opt in "${options[@]}"
do
    case $opt in
        "bash")            
            cmd="docker exec -it communities ssh"
            echo $cmd
            $cmd
            ;;
        "logs")
            cmd="docker-compose logs -f --tail 100"
            echo $cmd
            $cmd            
            ;;
        "kill")
            cmd="docker kill $(docker ps -q)"
            echo $cmd
            $cmd            
            ;;
        "reset")
            cmd="docker system prune -a"
            echo $cmd
            $cmd
            ;;
        "compose")
            cmd="docker-compose up -d"
            echo $cmd
            $cmd
            ;;
        "quit")
            break
            ;;
            
        *) 
            PS3="" # this hides the prompt
            echo asdf | select foo in "${options[@]}"; do break; done # dummy select 
            PS3="Please enter your choice: " # this displays the common prompt
            ;;
    esac
done