# Clear Systemd Journal Logs in Ubuntu 20.04
Systemd has its own logging system called the journal, and the log files are stored in `/var/log/journal`.

### Check current disk usage of journal files
```bash
sudo journalctl --disk-usage
```

### Rotate journal files
- Active journal files will be marked as archived, so that they are never written to in future.
```bash
sudo journalctl --disk-usage
```
### Delete journal logs older than 5 days:
```bash
sudo journalctl --vacuum-time=5days
```

### Delete log files until the disk space taken falls below 200M:
```bash
sudo journalctl --vacuum-size=200M
```

### Delete old logs and limit file number to 10:
```bash
sudo journalctl --vacuum-files=10
```

The configuration file is located at `/etc/systemd/journald.conf`. After editing to your preference, reload systemd daemon using `sudo systemctl daemon-reload` 
