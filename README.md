# Usage

cat [FILE] | ./crt_rec.sh [RECURSION LEVEL]

cat domains.txt | ./crt_rec.sh 2 

The output will be on the stdout so you may want to redirect it

cat domains.txt | ./crt_rec.sh 2 > crt_output.txt
