# Mosquitto broker (anonymous) - Home Assistant add-on repository

Fork of the official Mosquitto add-on with the authentication plugin removed:
every MQTT client connects, with or without a username/password.

## Install

1. In `repository.yaml` and `mosquitto_anonymous/config.yaml`, replace
   `YOUR_USER/YOUR_REPO` with your GitHub repository and push this folder to it.
2. In Home Assistant: **Settings > Add-ons > Add-on store > ⋮ > Repositories**,
   add your repository URL.
3. Install **Mosquitto broker (anonymous)**. It is built on your device, so the
   first install takes several minutes.
4. If the official Mosquitto broker is installed, stop it first (same ports).
