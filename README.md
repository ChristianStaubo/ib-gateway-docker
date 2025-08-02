# IB Gateway Docker

A headless Docker container that runs Interactive Brokers Gateway (v1039) with Xvfb and socat.

---

## Included Version

This project is designed for:

- `ibgateway-1039-standalone-linux-x64.sh`

This version is tested and stable. If you prefer to use the latest available version, see the instructions below.

> **Note**: The `.sh` installer is **not included** in this repository due to GitHub's 100MB file limit. You must download it manually (see next section).

---

## Using a Different IB Gateway Version

If you'd like to use the latest IB Gateway release:

1. Download the **Linux Standalone Installer** from [IBKR's official page](https://www.interactivebrokers.com/en/trading/ibgateway-latest.php)
2. Rename the file to match the version:
   ```text
   ibgateway-<version>-standalone-linux-x64.sh
   ```
   For example:
   ```text
   ibgateway-1040-standalone-linux-x64.sh
   ```
3. Place the file in the project root (same folder as the Dockerfile)
4. Update the Dockerfile:
   ```dockerfile
   ENV IB_GATEWAY_VERSION=1040
   ENV IB_INSTALLER=ibgateway-1040-standalone-linux-x64.sh
   ```

---

## Usage

### Build locally

```bash
docker build -t christianstaubo/ib-gateway-docker:latest .
```

### Or pull from Docker Hub

```bash
docker pull christianstaubo/ib-gateway-docker:latest
```

### Run it

```bash
docker run -it --rm christianstaubo/ib-gateway-docker:latest
```

This will:

- Start a headless X11 framebuffer (Xvfb)
- Expose port 4002 for TWS API connection
- Launch IB Gateway
- handle login via login.sh

---

## TODO

- [ ] Implement auto-login logic in login.sh
- [ ] Add restart logic for reboots
