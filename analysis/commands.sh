grep "Failed password" logs/bf_log1.log

grep "Failed password" logs/bf_log1.log | awk '{print $11}' | sort | uniq -c | sort -nr

grep "185.234.219.12" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

grep "185.234.219.12" logs/bf_log1.log | grep "Accepted"

grep "45.77.88.19" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

grep "45.77.88.19" logs/bf_log1.log | grep "Accepted"

grep "103.56.22.90" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

grep "103.56.22.90" logs/bf_log1.log | grep "Accepted" 

grep "Accepted" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'
