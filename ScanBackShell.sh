#!/bin/bash

# Menampilkan banner
PURPLE='\033[0;35m'
NC='\033[0m' # Tanpa Warna
echo -e "${PURPLE}# ScanBackShell v1.0${NC}"
echo -e "${PURPLE} ${NC}"
echo -e "${PURPLE} .|'''.|                           '||''|.                   '||       .|'''.|  '||              '||  '||  ${NC}"
echo -e "${PURPLE} ||..  '    ....   ....   .. ...    ||   ||   ....     ....   ||  ..   ||..  '   || ..     ....   ||   ||  ${NC}"
echo -e "${PURPLE}.     '|| ||      .|' ||   ||  ||   ||    || .|' ||  ||       ||'|.   .     '||  ||  ||  ||       ||   ||  ${NC}"
echo -e "${PURPLE}|'....|'   '|...' '|..'|' .||. ||. .||...|'  '|..'|'  '|...' .||. ||. |'....|'  .||. ||.  '|...' .||. .||. ${NC}"
echo -e "${PURPLE} ${NC}"
echo -e "${PURPLE} ${NC}"

                                                           

# Memeriksa apakah argumen telah diberikan
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Direktori yang akan dipindai
DIRECTORY=$1

# Memeriksa apakah direktori yang diberikan ada
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Direktory not found."
  exit 1
fi

# Daftar ekstensi yang akan dipindai
EXTENSIONS=("php" "php3" "php4" "php5" "phtml" "asp" "go")

# Daftar kata kunci yang akan dicari
# Ditambahkan 'system', 'passthru', 'proc_open', 'popen', 'pcntl_exec', 'eval', 'create_function', 'assert', 'include', 'require', 'fopen', 'fwrite', 'file_put_contents'
KEYWORDS=("backdoor" "shell" "cmd" "exec" "system" "passthru" "proc_open" "popen" "pcntl_exec" "eval" "create_function" "assert" "include" "require" "fopen" "fwrite" "file_put_contents")

# Variabel untuk memeriksa apakah potensi backdoor shell ada
POTENTIAL_SHELL_BACKDOOR_FOUND=0

# Variabel untuk kode warna
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Tanpa Warna

# Menampilkan pesan pemindaian dalam warna kuning
echo -e "${YELLOW}[Scanning potential backdoor shell in $DIRECTORY...]${NC}"

# Loop melalui setiap ekstensi
for EXT in "${EXTENSIONS[@]}"
do
  # Loop melalui setiap kata kunci
  for KEY in "${KEYWORDS[@]}"
  do
    # Menemukan file yang cocok dengan ekstensi dan mengandung kata kunci
    sudo find $DIRECTORY -type f -name "*.$EXT" -exec grep -q $KEY {} \; -quit
    if [ $? -eq 0 ]
    then
      # Jika file ditemukan, tambahkan tag [Backdoor] ke nama file dan tampilkan dalam warna merah
      sudo find $DIRECTORY -type f -name "*.$EXT" -exec sh -c 'echo "\e[0;31m[Backdoor]\e[0m " $0' {} \;
      POTENTIAL_SHELL_BACKDOOR_FOUND=1
      break
    fi
  done
done

# Memeriksa apakah potensi backdoor shell ada
if [ $POTENTIAL_SHELL_BACKDOOR_FOUND -eq 0 ]
then
  # Jika tidak ada potensi backdoor shell, tampilkan pesan dalam warna hijau
  echo -e "${GREEN}[Not Found Potential Backdoor Shell!]${NC}"
else
  # Jika potensi backdoor shell ada, tampilkan pesan dalam warna merah
  echo -e "${GREEN}[Scanning Complete]${NC}"
fi
