# Mosquitto broker (anonymous)

An MQTT broker that **accepts every client**. Clients may connect without
credentials, or with any username and password: the credentials are ignored and
the connection succeeds. There are no users and no ACLs, so every client can
publish and subscribe to every topic.

Only run this on a trusted network and do not expose ports 1883, 1884, 8883 or
8884 to the internet.

## Setup

1. Start the app. Do not run it alongside the official Mosquitto broker app,
   as both use port 1883.
2. In **Settings > Devices & Services**, accept the discovered MQTT integration.

The options (logging, SSL certificates, `customize`) work like the official
Mosquitto broker app.
