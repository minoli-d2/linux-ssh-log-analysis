# 🛡️ Security Incident Report – SSH Authentication Log Analysis

## 1. Executive Summary
This report presents an analysis of SSH authentication logs to identify unauthorized access attempts, brute-force attacks, and potential reconnaissance activity. The investigation reveals multiple external login attempts, including a concentrated brute-force attack pattern. No evidence of successful external system compromise was detected.

---

## 2. Scope of Analysis
- Log Source: SSH Authentication Logs (`bf_log1.log`)
- Focus: Failed and successful login attempts
- Objective: Detect brute-force attacks and suspicious login behavior

---

## 3. Tools & Commands Used
- grep (log filtering)
- awk (field extraction)
- sort & uniq (aggregation)

---

## 4. Findings

---

### 🔴 4.1 Confirmed Brute-Force Attack

**Source IP:** 185.234.219.12  
**Target Account:** root  

#### Evidence:
- 20 failed login attempts recorded
- Attempts occurred at consistent short intervals (~2 seconds apart)
- Repeated targeting of privileged account (root)

#### Command Used:

grep "185.234.219.12" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

#### Interpretation:

The consistent timing and high frequency of failed login attempts strongly indicate automated brute-force activity, likely using an attack script or tool.
No successful authentication attempts were observed from this IP.

---

### 🟠 4.2 Suspicious Activity – Possible Reconnaissance

Source IP: 45.77.88.19
Evidence:

    2 failed login attempts only
    No sustained attack pattern

#### Command Used:

grep "45.77.88.19" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

#### Interpretation:

Low-frequency attempts suggest probing or reconnaissance behavior, rather than a full brute-force attack.
No successful authentication observed.

---

### 🟠 4.3 Suspicious Activity – Targeted Login Attempts

Source IP: 103.56.22.90
Target Account: admin
Evidence:

    2 failed login attempts
    Targeting a privileged account

#### Interpretation:

This activity may indicate initial password guessing or reconnaissance, but is insufficient to confirm a sustained attack.
No successful authentication observed.

---

### 🟢 4.4 Successful Internal Authentication

Source IP Range: 192.168.1.0/24
Evidence:

    Multiple successful logins recorded
    Users: alice, bob, charlie, admin, david
    All logins originate from internal/private IP addresses

#### Command Used:

grep "Accepted" logs/bf_log1.log | awk '{print $1,$2,$3,$9,$11}'

#### Interpretation:

All successful authentication events originate from internal network IPs, indicating legitimate user activity. No external successful logins were detected.

---

## 5. Impact Assessment

    No external system compromise detected
    Brute-force attack was unsuccessful
    System integrity remains intact

---

## 6. Security Recommendations

    Block or rate-limit repeated failed login IPs
    Disable root login over SSH
    Implement key-based authentication instead of passwords
    Deploy fail2ban or similar intrusion prevention tools
    Continuously monitor authentication logs

---

## 7. Conclusion

The system experienced multiple external login attempts, including a confirmed automated brute-force attack targeting the root account. While no unauthorized access was achieved, continued exposure without mitigation could increase risk. Strengthening SSH security controls is strongly recommended.
