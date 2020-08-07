# Usage

cat [FILE] | ./crt_rec.sh [RECURSION LEVEL]

cat domains.txt | ./crt_rec.sh 2 

The output will be on the stdout so you may want to redirect it

cat domains.txt | ./crt_rec.sh 2 > crt_output.txt

./crt_rec.sh 2 >> crt_results.txt 2> >(tee -a log_crt.txt >&2)


Note: It'll take some time to finish so I recommend running it on a VPS, also recursion level higher than 2 is not recommended because it'll be REALLY slow.
