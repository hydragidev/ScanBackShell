<?php

// Menampilkan banner
echo "\033[0;35m# ScanBackShell v1.0\033[0m\n";
echo "\033[0;35m \033[0m\n";
echo "\033[0;35m  .|'''.|                           '||''|.                   '||       .|'''.|  '||              '||  '||  \033[0m\n";
echo "\033[0;35m  ||..  '    ....   ....   .. ...    ||   ||   ....     ....   ||  ..   ||..  '   || ..     ....   ||   ||  \033[0m\n";
echo "\033[0;35m .     '|| ||      .|' ||   ||  ||   ||    || .|' ||  ||       ||'|.   .     '||  ||  ||  ||       ||   ||  \033[0m\n";
echo "\033[0;35m |'....|'   '|...' '|..'|' .||. ||. .||...|'  '|..'|'  '|...' .||. ||. |'....|'  .||. ||.  '|...' .||. .||. \033[0m\n";
echo "\033[0;35m \033[0m\n";
echo "\033[0;35m \033[0m\n";

// Memeriksa apakah argumen telah diberikan
if ($argc < 2) {
    echo "Usage: php $argv[0] <direktori>\n";
    exit(1);
}

// Direktori yang akan dipindai
$directory = $argv[1];

// Memeriksa apakah direktori yang diberikan ada
if (!is_dir($directory)) {
    echo "Error: Direktory not found.\n";
    exit(1);
}

// Daftar ekstensi yang akan dipindai
$extensions = ["php", "php3", "php4", "php5", "phtml", "asp", "go"];

// Daftar kata kunci yang akan dicari
$keywords = ["backdoor", "shell", "cmd", "exec", "system", "passthru", "proc_open", "popen", "pcntl_exec", "eval", "create_function", "assert", "include", "require", "fopen", "fwrite", "file_put_contents"];

// Variabel untuk memeriksa apakah potensi backdoor shell ada
$potentialShellBackdoorFound = false;

// Variabel untuk kode warna
$yellow = "\033[1;33m";
$green = "\033[0;32m";
$red = "\033[0;31m";
$nc = "\033[0m"; // Tanpa Warna

// Menampilkan pesan pemindaian dalam warna kuning
echo "\033[1;33m[Scanning potential backdoor shell] [ Path : ".$directory."]\033[0m\n";

// Loop melalui setiap ekstensi
foreach ($extensions as $ext) {
    // Loop melalui setiap kata kunci
    foreach ($keywords as $key) {
        // Mencari file yang cocok dengan ekstensi dan mengandung kata kunci
        $files = glob("$directory/*.$ext");
        foreach ($files as $file) {
            $fileContent = file_get_contents($file);
            if (stripos($fileContent, $key) !== false) {
                // Jika file ditemukan, tambahkan tag [Backdoor] ke nama file dan tampilkan dalam warna merah
                echo "$red[Backdoor] $file$nc\n";
                $potentialShellBackdoorFound = true;
                break;
            }
        }
        if ($potentialShellBackdoorFound) {
            break;
        }
    }
    if ($potentialShellBackdoorFound) {
        break;
    }
}

// Memeriksa apakah potensi backdoor shell ada
if (!$potentialShellBackdoorFound) {
    // Jika tidak ada potensi backdoor shell, tampilkan pesan dalam warna hijau
    echo "\033[0;32m[Not Found Potential Backdoor Shell!]\033[0m\n";
} else {
    // Jika potensi backdoor shell ada, tampilkan pesan dalam warna merah
    echo "\033[0;32m[Scanning Complete]\033[0m\n";
}
?>
