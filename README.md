#  SSH Log Analysis – Brute Force Detection Project

##  Overview

This project demonstrates a practical cybersecurity investigation of SSH authentication logs to detect brute-force attacks, identify suspicious login behavior, and assess system compromise.

The analysis simulates a real-world Security Operations Center (SOC) workflow using Linux command-line tools.

---

##  Objectives

* Detect brute-force attacks from log data
* Identify suspicious or reconnaissance activity
* Differentiate between malicious and legitimate logins
* Perform evidence-based security analysis

---

##  Tools & Technologies

* Kali Linux (Virtual Machine)
* Linux CLI tools: `grep`, `awk`, `sort`, `uniq`
* Git & GitHub for version control

---

##  Project Structure

```
linux-ssh-log-analysis/
│
├── logs/                 # Raw log dataset
├── analysis/             
│   ├── commands.sh       # Commands used during investigation
│   └── analysis_notes.md # Step-by-step analysis & reasoning
│
├── reports/              
│   └── incident_report.md # Final SOC-style incident report
│
├── screenshots/          # Evidence snapshots
├── session.log           # Full terminal session recording
└── README.md
```

---

##  Key Findings

### 🔴 Brute-Force Attack Detected

* **IP:** 185.234.219.12
* **Behavior:** 20 failed login attempts
* **Pattern:** Consistent ~2-second intervals
* **Target:** root account

➡️ Indicates likely **automated brute-force attack**

---

### 🟠 Suspicious Activity (Reconnaissance)

* **45.77.88.19:** 2 failed attempts
* **103.56.22.90:** 2 failed attempts (targeting admin)

➡️ Possible early-stage probing or password guessing

---

### 🟢 Legitimate Access

* All successful logins originate from **internal IPs (192.168.1.x)**
* No external IP successfully authenticated

➡️ No evidence of system compromise

---

##  Investigation Approach

1. Extract failed login attempts
2. Identify top attacking IPs
3. Analyze timing patterns for automation
4. Verify successful vs failed logins
5. Correlate internal vs external access

---

##  Security Assessment

* Brute-force attack detected but unsuccessful
* No unauthorized access observed
* System remains uncompromised

---

##  Recommendations

* Disable root login over SSH
* Implement key-based authentication
* Use tools like `fail2ban` to block repeated attempts
* Monitor authentication logs continuously

---

##  Evidence

Screenshots and full terminal session logs are included to support the analysis.

---

##  What I Learned

* Real-world log analysis using Linux tools
* Detecting brute-force patterns through timing and frequency
* SOC-style investigation and reporting
* Importance of validating findings with evidence

---

##  Future Improvements

* Automate detection using scripts
* Integrate logs into SIEM tools (e.g., Splunk)
* Build dashboards for visualization
* Expand dataset with multiple attack scenarios

---

##  Author

Minoli Silva
Cybersecurity Enthusiast | Aspiring SOC Analyst
