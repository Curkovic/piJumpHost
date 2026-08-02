# PiJumpHost

Turn an old Raspberry Pi into a browser-accessible SSH jump host using **Raspberry Pi Connect**.

The goal of this project is simple: provide secure access to your home network from anywhere without exposing SSH to the Internet or maintaining a VPN. If Raspberry Pi Connect works, your jump host works.

---

## Why?

I had an old Raspberry Pi collecting dust.

Instead of buying new hardware or setting up a complex VPN solution, I reused it as a dedicated jump host. Raspberry Pi Connect provides secure browser access to the Pi, and from there a single command connects me to my home server using an SSH key.

The Pi is designed to be an appliance—not another server to manage.

Once configured, it updates itself, monitors its own services, performs scheduled maintenance, and requires virtually no manual intervention.

---

> **Disclaimer**
>
> PiJumpHost is intended as a reference implementation rather than a copy-and-paste solution. The included script is configured for my own environment and searches for a specific local hostname during its automatic failover process. You will need to adjust hostnames, usernames, network ranges, and any environment-specific logic to match your own setup.
>
> To make customization easier, the repository includes two versions:
>
> * **`bashrc`** – the complete version with automatic target discovery and failover.
> * **`bashrc_clean`** – a simplified version without the auto-discovery logic, intended as a starting point for your own implementation.
>
> Every home network is different, so treat this project as a foundation to build on rather than a drop-in solution.

---

## Features

* Browser access through Raspberry Pi Connect
* SSH key authentication from Pi → Server
* Password authentication can remain enabled for other devices
* Automatic fallback when hostname resolution fails
* Network discovery using `nmap`
* Cyberpunk-inspired terminal interface
* Designed for unattended operation
* Works well on older Raspberry Pi hardware

---

## Architecture

```text
                Internet
                    │
                    ▼
        Raspberry Pi Connect
                    │
                    ▼
             Raspberry Pi
             (Jump Host)
                    │
         SSH (ED25519 Key)
                    │
                    ▼
             Home Server
```

---

## Connection Flow

1. Open Raspberry Pi Connect from any browser.
2. Open the terminal.
3. The `jump` script starts automatically.
4. A five-second countdown allows cancellation.
5. The Pi attempts to connect to `itechie.local`.
6. If mDNS fails, the script scans the local subnet.
7. The server is located automatically.
8. SSH session starts.

The idea is simple:

> Open browser → Open terminal → You're on your server.

---

## Fallback Logic

If hostname resolution fails:

```text
Attempt hostname
        │
        ▼
Connection failed
        │
        ▼
Scan local subnet with nmap
        │
        ▼
Find matching hostname
        │
        ▼
Reconnect automatically
```

This avoids relying entirely on consumer routers, which occasionally lose local hostname records.

---

## Why not use a static IP?

Because I don't need one.

My network uses DHCP, and this project embraces that instead of fighting it.

If DNS resolution works, great.

If it doesn't, PiJumpHost automatically discovers the server again.

The objective is reliability with minimal maintenance rather than perfect network configuration.

---

## Philosophy

This project follows a simple principle:

> Build once. Forget about it.

The Raspberry Pi should behave like an appliance.

It should quietly:

* update itself
* keep required services running
* reboot occasionally for long-term stability
* require almost no maintenance

If everything works, there should be no reason to SSH into the Pi itself.

---

## Requirements

* Raspberry Pi (any model capable of running Raspberry Pi OS)
* Raspberry Pi OS
* Raspberry Pi Connect
* OpenSSH
* `nmap`
* SSH key configured between the Pi and your destination server

---

## Example Banner

```text
>> INITIALIZING iTechie NEURAL SOURCE... [JumpHost Ready]

[AUTH] Public-key identity loaded
[TARGET] itechie.local
[STATE] Ready to establish secure session

------------------------------------------------
WELCOME TO Cyber Jump Host
Connecting to itechie.local in 5s...
Press 'n' to cancel.
------------------------------------------------
```

---

## Why Raspberry Pi Connect?

Because it's free.

If Raspberry Pi Connect already gives secure browser access to the Pi, it becomes an excellent entry point into the rest of the home network without exposing additional services to the Internet.

An old Raspberry Pi suddenly becomes useful again.

---

## Future Ideas

* Configurable target hostname
* Multiple server profiles
* Interactive menu
* Wake-on-LAN integration
* Health dashboard
* Optional notifications
* Better logging
* Automatic dependency installer

---

## Contributing

Suggestions and improvements are welcome.

The project intentionally favors simplicity over unnecessary complexity.

---

## License

MIT License
