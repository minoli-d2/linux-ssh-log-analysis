#   SSH Log Investigation Report

---

## 1. Objective

To analyze SSH authentication logs in order to detect brute-force attacks, reconnaissance activity, and distinguish between malicious and legitimate login attempts.

---

## 2. Brute Force Activity Analysis

###  Command Used:

grep "Failed password" logs/bf_log1.log | awk '{print $11}' | sort | uniq -c | sort -nr

###  Key Output:

    185.234.219.12 → 20 failed attempts
    45.77.88.19 → 2 failed attempts
    103.56.22.90 → 2 failed attempts

###  Interpretation:

The IP address 185.234.219.12 shows a significantly higher number of failed authentication attempts compared to other sources. This indicates a concentrated attack pattern targeting SSH authentication, consistent with a brute-force attack attempt.

The remaining IPs show low-frequency attempts, suggesting possible probing or early-stage reconnaissance activity rather than sustained attacks.

---

## 3. Detailed Analysis of Primary Attacker (185.234.219.12)

###  Command Used:

grep "185.234.219.12" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

###  Key Output (sample):

Apr 23 10:00:01 root 185.234.219.12
Apr 23 10:00:03 root 185.234.219.12
...
Apr 23 10:03:09 root 185.234.219.12

###  Interpretation:

The login attempts occur at very short and consistent time intervals (approximately 2 seconds apart), targeting the root account repeatedly. This timing pattern strongly suggests automated brute-force activity.

###  Verification Commands:

grep "185.234.219.12" logs/bf_log1.log | grep "Accepted"

###  Verification Result:

No successful authentication attempts were observed from this IP. All activity consists of repeated failed login attempts.

---

## 4. Analysis of Secondary IP (45.77.88.19)

###  Command Used:

grep "45.77.88.19" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

###  Output:

Two failed login attempts were recorded targeting the root account.

###  Verification Commands:

grep "45.77.88.19" logs/bf_log1.log | grep "Accepted"

###  Interpretation:

No successful authentication attempts were observed from this IP. 
Low-frequency failed attempts suggest initial probing or reconnaissance behavior rather than a sustained brute-force attack.

---

## 5. Analysis of Secondary IP (103.56.22.90)

###  Command Used:

grep "103.56.22.90" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

###  Output:

Two failed login attempts targeting the admin account.

###  Verification Commands:

grep "103.56.22.90" logs/bf_log1.log | grep "Accepted"

###  Interpretation:

No successful authentication attempts were observed from this IP.
This indicates targeted login attempts against a privileged account. However, due to the low frequency and lack of persistence, the activity is classified as suspicious but inconclusive.

---

## 6. Successful Authentication Analysis

###  Command Used:

grep "Accepted" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

###  Output:

    alice → 192.168.1.10
    bob → 192.168.1.11
    charlie → 192.168.1.15
    admin → 192.168.1.12
    david → 192.168.1.20

###  Interpretation:

All successful logins originate from internal private IP addresses (192.168.1.0/24 range). This indicates legitimate internal or trusted network access. No external IP addresses achieved successful authentication.

---

## 7. Final Security Assessment

###  Findings:

    Confirmed brute-force attack from 185.234.219.12
    Possible reconnaissance activity from 45.77.88.19 and 103.56.22.90
    No external successful authentication detected
    Internal authentication appears normal

###  Conclusion:

The system experienced external attack attempts but no evidence of compromise was found. The most significant threat is an automated brute-force attack targeting the root account.

