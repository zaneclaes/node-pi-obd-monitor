# Node Pi OBD Monitor
An OBD reader in a Docker container for Raspberry Pi with Prometheus exporting.

# Features
* Automatically connects to the OBD port via [python-OBD](https://github.com/brendan-w/python-OBD).
* Exports all `Unit.*` commands as `Gauges` via the [prometheus/client_python](https://github.com/prometheus/client_python) on port 8000.
* Runs idendefinitely, re-connecting to the car as it appears and disappears.

# Installation

## Pre-requisites
A Raspberry Pi with a serial OBD reader, or with a Bluetooth reader connected to `/dev/rfcomm0`. See [these instructions](https://medium.com/@fsjohnny/connecting-your-bluetooth-obdii-adapter-or-other-serial-port-adapters-to-a-raspberry-pi-3-f2c9663dae73) for help.

## Manual Installation on Kubernetes
```
kubectly apply -f https://raw.githubusercontent.com/zaneclaes/tiny-cluster/master/kubernetes/obd-monitor.yaml
```

And then label the nodes which you wish to deploy on (replacing `[NODE_NAME]` with your node):
```
kubectl label nodes [NODE_NAME] tiny-cluster/node-pi-obd-monitor=true
```

## Run with Docker
Assuming the device resides at `/dev/rfcomm0`, the command will be something like this:
```
docker run --rm --name obd-monitor --mount "type=bind,source=/dev/rfcomm0,target=/dev/rfcomm0" --privileged=true inzania/node-pi-obd-monitor:latest
```
