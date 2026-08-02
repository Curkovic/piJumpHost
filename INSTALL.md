# Installation Guide

This guide uses **`bashrc_clean`**, the recommended version for most users.

---

# Requirements

Before installing PiJumpHost, make sure you have:

* A Raspberry Pi running Raspberry Pi OS
* Raspberry Pi Connect configured and working
* SSH installed (included by default on Raspberry Pi OS)
* A destination server you want to connect to

---

# Step 1 – Connect to your Raspberry Pi

Open a terminal on your computer and connect to your Raspberry Pi using SSH.

Example:

```bash
ssh pi@raspberrypi.local
```

or

```bash
ssh pi@192.168.1.100
```

Replace the hostname or IP address with your Raspberry Pi's address.

---

# Step 2 – Locate your `.bashrc`

Your shell configuration is stored in a file named:

```text
~/.bashrc
```

Notice the **dot (`.`)** at the beginning of the filename.

On Linux, files and folders beginning with a dot are **hidden files**. They are used for configuration and normally won't appear unless hidden files are enabled.

---

# Step 3 – Open `.bashrc`

Open the file with Nano:

```bash
nano ~/.bashrc
```

Scroll to the **bottom** of the file.

Do **not** replace the existing contents.

Instead, paste the contents of **`bashrc_clean`** at the end of the file.

---

# Step 4 – Update the configuration

Near the top of the script you'll find:

```bash
TARGET_HOST="server.local"
TARGET_USER="username"
CONNECT_TIMEOUT=5
```

Replace them with your own values.

Example:

```bash
TARGET_HOST="homeserver.local"
TARGET_USER="mate"
CONNECT_TIMEOUT=5
```

You may also use an IP address instead of a hostname:

```bash
TARGET_HOST="192.168.1.42"
```

---

# Step 5 – Save the file

Nano displays its keyboard shortcuts at the bottom of the screen.

The most important ones are:

| Shortcut     | Action               |
| ------------ | -------------------- |
| **Ctrl + O** | Save the file        |
| **Enter**    | Confirm the filename |
| **Ctrl + X** | Exit Nano            |

---

# Step 6 – Reload `.bashrc`

The easiest method is simply to disconnect and reconnect to your Raspberry Pi.

To disconnect from the current SSH session, type:

```bash
exit
```

or press:

```text
Ctrl + D
```

Then connect again:

```bash
ssh pi@raspberrypi.local
```

When a new shell starts, `.bashrc` is loaded automatically and PiJumpHost will launch.

Alternatively, you can reload the file without reconnecting:

```bash
source ~/.bashrc
```

---

# Step 7 – Configure SSH keys (Recommended)

PiJumpHost works best when the Raspberry Pi authenticates to your server using an SSH key.

Generate a key:

```bash
ssh-keygen -t ed25519
```

Copy the public key to your destination server:

```bash
ssh-copy-id your_username@your_server
```

After that, PiJumpHost will connect without asking for a password.

---

# Finished

Each time you open a new terminal on the Raspberry Pi, PiJumpHost will automatically start and connect to your configured server after the countdown.

Enjoy your new browser-accessible jump host!
