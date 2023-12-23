## ScanBackShell v1.0

ScanBackShell adalah sebuah skrip bash sederhana yang dirancang untuk memindai direktori tertentu dan mencari potensi backdoor shell dalam berbagai jenis file. Skrip ini menggunakan daftar ekstensi file dan kata kunci yang umumnya terkait dengan backdoor atau serangan keamanan pada aplikasi web.
### Penggunaan
```bash
chmod +x ScanBackShell.sh
./ScanBackShell.sh <directory>

```
- <directory>: Direktori yang akan dipindai untuk mencari potensi backdoor.

## Daftar Ekstensi dan Kata Kunci
### Ekstensi File

- php
- php3
- php4
- php5
- phtml
- asp
- go

### Kata Kunci

- backdoor
- shell
- cmd
- exec
- system
- passthru
- proc_open
- popen
- pcntl_exec
- eval
- create_function
- assert
- include
- require
- fopen
- fwrite
- file_put_contents

### Output

- Jika tidak ditemukan potensi backdoor, pesan "Not Found Potential Shell Backdoor Existing!" akan ditampilkan dalam warna hijau.
- Jika potensi backdoor ditemukan, skrip akan menandai file dengan tag [Backdoor] dan menampilkan nama file dalam warna merah. Pesan "Scanning Complete" akan ditampilkan dalam warna merah.
