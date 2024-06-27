<div align="center">
  <img src="./pppwn/logo.svg" alt="Logo" width="200"/>
</div>

# Fork of [Davi5Alexander/docker_pppwn](https://github.com/Davi5Alexander/docker_pppwn), modified to use with [xfangfang/PPPwn_cpp](https://github.com/xfangfang/PPPwn_cpp), due to its faster execution speed.

This repository contains Docker files to run [xfangfang/PPPwn_cpp](https://github.com/xfangfang/PPPwn_cpp)
and [TheOfficialFloW/PPPwn](https://github.com/TheOfficialFloW/PPPwn) easily using an Alpine image.
It's ideal for running on a Raspberry Pi with a dedicated USB to Ethernet port for the PS4. PPPwn is a kernel
remote code execution exploit for PlayStation 4 up to FW 11.00.
It's a proof-of-concept exploit for [CVE-2006-4304](https://hackerone.com/reports/2177925) that was responsibly reported to PlayStation.
Inspired by [Davi5Alexander/docker_pppwn](https://github.com/Davi5Alexander/docker_pppwn) and [stooged/PI-Pwn](https://github.com/stooged/PI-Pwn).

## Requirements
- PS4 with 11.00 firmware.
- Docker installed on your system.
- Ethernet cable.
- USB with [GoldHen](https://github.com/GoldHEN/GoldHEN) (only for the first time).
- Binaries for [`pppwn`](./pppwn/README.md) and [`stage1`, `stage2`](./pppwn/stages/README.md)

## Usage
1. Clone the repository.
2. Edit `docker-compose.yml` and change the environments: `INTERFACE` (eth0, eth1, etc).
3. Run `docker compose up -d`; Follow the logs if needed `docker compose logs -f`
4. Check the logs, stop the script, start it, and restart it using port 8066 on your server, for example, http://192.168.1.2:8066 (you can change it in `nginx/default.conf`).
5. Turn on the PS4.

On your PS4 (first time):

1. Insert the USB with `goldhen.bin` into the PS4.
2. Go to Settings and then to Network.
3. Select Set Up Internet Connection and choose Use a LAN Cable.
4. Choose Custom Setup and select PPPoE for IP Address Settings.
5. Enter anything for PPPoE User ID and PPPoE Password.
6. Choose Automatic for DNS Settings and MTU Settings.
7. Choose Do Not Use for Proxy Server.

![Demo](https://i.imgur.com/dKblI6Y.gif)