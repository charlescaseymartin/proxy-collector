#!/usr/bin/bash

# This script gets the top 800 proxies from all SpeedX proxy lists
make_file() {
    file_path=$1

    if [[ ! -f "$file_path" ]]; then
        mkdir -p $(dirname "$file_path")
        touch $(basename "$file_path")
    fi
}

output=$1

if [[ -z "$output" ]]; then
    output="./proxies.txt"
    make_file $output
else
    make_file $output
fi

declare -a proxy_urls
proxy_urls[0]="https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks5.txt"
proxy_urls[1]="https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks4.txt"
proxy_urls[2]="https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/http.txt"

echo "[+] Fetching proxies..."
for url in "${proxy_urls[@]}"
do
    curl -s "$url" | head -n 800 >> $output
done
echo "[+] Proxies writen to $output"
