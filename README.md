# oss-audit-24BAI10311

**Name:** Khushi Khatri
**Reg No:** 24BAI10311
**Course:** Open Source Software — OSS NGMC Capstone
**University:** VIT Bhopal University
**Chosen Software:** Git

---

## Scripts

| Script | Description |
|---|---|
| script1_system_identity.sh | Displays system info, kernel version, user, uptime and GPL v2 license note |
| script2_package_inspector.sh | Checks if Git is installed, shows version, metadata and philosophy note |
| script3_disk_permission_auditor.sh | Audits directory permissions, disk usage and Git config locations |
| script4_log_analyzer.sh | Reads a log file, counts keyword matches and shows last 5 matching lines |
| script5_manifesto_generator.sh | Takes user input and generates a personal open-source manifesto |

---

## How to Run
```bash
chmod +x *.sh

bash script1_system_identity.sh
bash script2_package_inspector.sh
bash script3_disk_permission_auditor.sh
bash script4_log_analyzer.sh /var/log/syslog error
bash script5_manifesto_generator.sh
```

---

## Dependencies
Bash 4.0+, Git, standard Linux utilities (uname, grep, awk, du, ls, date)
