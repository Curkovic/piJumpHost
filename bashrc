jump() {
    echo -e "\033[1;35m" # Magenta
    echo -n ">> INITIALIZING iTechie NEURAL SOURCE"
    for i in {1..3}; do
        echo -n "."
    sleep 0.5
    done
    echo -e " [JumpHost Ready]"
    sleep 0.2
    # SSH status
    echo -e "\033[1;32m[AUTH] Public-key identity loaded\033[0m"
    sleep 0.2
    echo -e "\033[1;36m[TARGET] itechie.local\033[0m"
    sleep 0.2
    echo -e "\033[1;34m[STATE] Ready to establish secure session\033[0m"
    sleep 0.2
    echo -e "\033[0;36m"
    echo "------------------------------------------------"
    sleep 0.2
    echo "  WELCOME TO Cyber Jump Host"
    sleep 0.2
    echo "  Connecting to itechie.local in 5s..."
    sleep 0.2
    echo "  Press 'n' to cancel."
    sleep 0.2
    echo "------------------------------------------------"
    echo -e "\033[0m"

    read -t 5 -n 1 key
    if [[ $key != "n" ]]; then
        if ! ssh -o ConnectTimeout=3 mate@itechie.local; then
            echo -e "\033[1;31m[!] Hostname resolve failed. Scanning network via nmap...\033[0m"

            TARGET_IP=$(nmap -sn 192.168.1.0/24 | grep -i -B 2 "itechie" | grep -oP '\(\K[0-9.]+(?=\))' | head -n 2 | tail -1)

            if [[ -n "$TARGET_IP" ]]; then
                echo -e "\033[1;32m[+] Found target IP: $TARGET_IP. Connecting...\033[0m"
                ssh "mate@$TARGET_IP"
            else
                echo -e "\033[1;31m[-] Target not found on network.\033[0m"
            fi
        fi
    else
        echo "Connection aborted by operator."
    fi
}
jump
