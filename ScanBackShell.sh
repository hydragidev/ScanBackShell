#!/bin/bash

# Display banner
PURPLE='\033[0;35m'
NC='\033[0m' # No Color
echo -e "${PURPLE}# ScanBackShell v1.0${NC}"
echo -e "${PURPLE} ${NC}"
echo -e "${PURPLE} .|'''.|                           '||''|.                   '||       .|'''.|  '||              '||  '||  ${NC}"
echo -e "${PURPLE} ||..  '    ....   ....   .. ...    ||   ||   ....     ....   ||  ..   ||..  '   || ..     ....   ||   ||  ${NC}"
echo -e "${PURPLE}.     '|| ||      .|' ||   ||  ||   ||    || .|' ||  ||       ||'|.   .     '||  ||  ||  ||       ||   ||  ${NC}"
echo -e "${PURPLE}|'....|'   '|...' '|..'|' .||. ||. .||...|'  '|..'|'  '|...' .||. ||. |'....|'  .||. ||.  '|...' .||. .||. ${NC}"
echo -e "${PURPLE} ${NC}"
echo -e "${PURPLE} ${NC}"

                                                           

# Check if an argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Directory to scan
DIRECTORY=$1

# Check if the provided directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: The specified directory does not exist."
  exit 1
fi

# List of extensions to scan
EXTENSIONS=("php" "php3" "php4" "php5" "phtml" "asp" "go")

# List of keywords to search for
# Added 'system', 'passthru', 'proc_open', 'popen', 'pcntl_exec', 'eval', 'create_function', 'assert', 'include', 'require', 'fopen', 'fwrite', 'file_put_contents'
KEYWORDS=("backdoor" "shell" "cmd" "exec" "system" "passthru" "proc_open" "popen" "pcntl_exec" "eval" "create_function" "assert" "include" "require" "fopen" "fwrite" "file_put_contents")

# Variable to check if potential shell backdoor exists
POTENTIAL_SHELL_BACKDOOR_FOUND=0

# Variable for color codes
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Display scanning message in yellow
echo -e "${YELLOW}[Scanning for potential shell backdoors in $DIRECTORY...]${NC}"

# Loop through each extension
for EXT in "${EXTENSIONS[@]}"
do
  # Loop through each keyword
  for KEY in "${KEYWORDS[@]}"
  do
    # Find files that match the extension and contain the keyword
    sudo find $DIRECTORY -type f -name "*.$EXT" -exec grep -q $KEY {} \; -quit
    if [ $? -eq 0 ]
    then
      # If a file is found, add a tag [Backdoor] to the file name and display it in red
      sudo find $DIRECTORY -type f -name "*.$EXT" -exec sh -c 'echo "\e[0;31m[Backdoor]\e[0m " $0' {} \;
      POTENTIAL_SHELL_BACKDOOR_FOUND=1
      break
    fi
  done
done

# Check if potential shell backdoor exists
if [ $POTENTIAL_SHELL_BACKDOOR_FOUND -eq 0 ]
then
  # If no potential shell backdoor exists, display message in green
  echo -e "${GREEN}[Not Found Potential Shell Backdoor Existing!]${NC}"
else
  # If potential shell backdoor exists, display message in red
  echo -e "${GREEN}[Scanning Complete]${NC}"
fi
