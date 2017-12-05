#Find words/patterns in files and return which files have that pattern

#The pattern to find, standard regex syntax

regex="draft = true"
PWD=$(pwd)
#get the files in the current directory ending with .md
files=$(find "$PWD" -name "*.md")
lines=""

for file in $files ; do

    lines=$(cat "$file")

     #get the content in the current file
     #echo $file
     #for line in $lines ; do
        # echo $line
        if [[ $lines =~ $regex ]]; then
         #if the line matches the pattern
         echo -e "\033[92m" + " Match found! \033[0m Match is $regex in \033[36m $file \033[0m"
        fi
     #done

done
