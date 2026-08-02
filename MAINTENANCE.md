# Maintenance

One of the core ideas behind PiJumpHost is simple:

> **Build once. Forget about it.**

The Raspberry Pi should behave like an appliance.

It should quietly:

* keep itself updated
* recover from common failures
* clean up after itself
* require little or no manual maintenance

This repository includes the maintenance routine I personally use on my own jump host. It is **not required**, but it demonstrates how I keep the system running unattended.

---

# Installing the Cron Jobs

The included **`crontab`** file should be installed as the **root** crontab.

Become the root user:

```bash
sudo su -
```

Open the root crontab:

```bash
crontab -e
```

Paste the contents of **`crontab`** into the editor.

Save and exit.

If Nano is your default editor:

| Shortcut     | Action               |
| ------------ | -------------------- |
| **Ctrl + O** | Save the file        |
| **Enter**    | Confirm the filename |
| **Ctrl + X** | Exit Nano            |

Cron will automatically begin using the new schedule.

When you're finished, leave the root shell:

```bash
exit
```

---

# Understanding the Jobs

## Scheduled Reboot

```cron
0 4 * * * /sbin/shutdown -r now
```

Reboots the Raspberry Pi every day at **04:00**.

This is completely optional.

Many Raspberry Pi systems can run for months without rebooting, but I prefer a scheduled restart to recover from any unexpected long-running issues.

Feel free to adjust the schedule or remove this job entirely.

---

## Automatic System Updates

```cron
0 3 1 * * dpkg --configure -a --force-confold && apt update && apt full-upgrade -y && apt autoremove -y && apt clean
```

Runs on the **1st day of every month at 03:00**.

This job automatically:

* finishes interrupted package installations
* updates package lists
* installs available upgrades
* removes unused packages
* cleans the package cache

The goal is to keep the jump host secure without requiring manual maintenance.

---

## Log Cleanup

```cron
0 2 * * 0 journalctl --vacuum-time=7d
```

Runs every Sunday at **02:00**.

Old system logs are removed after seven days to reduce unnecessary writes to the SD card and prevent logs from consuming disk space.

---

## SSH Health Check

```cron
*/15 * * * * systemctl is-active --quiet ssh || systemctl restart ssh
```

Every 15 minutes, the system checks whether the SSH service is still running.

If it has stopped for any reason, it is automatically restarted.

---

## Raspberry Pi Connect Health Check

```cron
*/15 * * * * systemctl --user -M mate@ is-active --quiet rpi-connect || systemctl --user -M mate@ restart rpi-connect
```

Every 15 minutes, the Raspberry Pi checks whether the Raspberry Pi Connect service is still running.

If it isn't, the service is automatically restarted.

---

# Important

Although these jobs are installed in the **root crontab**, Raspberry Pi Connect itself runs as a **user service**.

Because of that, the following command contains **my username**:

```text
mate
```

You **must** replace it with your own Linux username.

For example, if your username is **pi**:

```cron
*/15 * * * * systemctl --user -M pi@ is-active --quiet rpi-connect || systemctl --user -M pi@ restart rpi-connect
```

You can check your username before becoming root:

```bash
whoami
```

or, from the root shell:

```bash
logname
```

Use whichever username owns the Raspberry Pi Connect session.

---

# Why Is a Username Required?

Unlike SSH, Raspberry Pi Connect is **not** a system service.

It runs inside a user's session, so `systemctl` needs to know **which user's** service it should monitor and restart.

If you use the wrong username, the Raspberry Pi Connect health check will not work, even though the other maintenance tasks will continue to function normally.

---

# Philosophy

Could this setup be more sophisticated?

Absolutely.

You could use monitoring software, configuration management, containers, or external health checks.

That isn't the goal of PiJumpHost.

The goal is to take an old Raspberry Pi, give it one job, and let it quietly do that job every day with as little human intervention as possible.

If months go by without needing to SSH into the Raspberry Pi itself, then PiJumpHost is doing exactly what it was designed to do.
