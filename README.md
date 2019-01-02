# HoneywellSecurityMQTT

This project is based on fusterjj's HonewellSecurityMQTT project which was based on jhaines0's HoneywellSecurity.  It listen's for events from 345MHz security sensors and sends messages via MQTT.  

I attempted for simple event/message translation, but some state/persistance was required to acheive debouncing of signals.


## Features
 - Decodes data from sensors based on Honeywell's 345MHz system.  This includes rebrands such as 2GIG, Vivint, etc.
 - Requires no per-sensor configuration
 - Decodes sensor status such as tamper and low battery
 - Reports alarm and sensor status to an MQTT broker
 - **NEW** Support for multisensors.  For example, a water sensor with high-temp and low-temp alerts.
 - **NEW** Support for some 345 keyfobs and 345 keypads.

## Requirements
 - RTL-SDR USB adapter; commonly available on Amazon
 - rtlsdr library
 - mosquittopp library
 - gcc

## Installation
### Dependencies
On a Debian-based system, something like this should work:
```
  sudo apt-get install build-essential librtlsdr-dev rtl-sdr libmosquittopp-dev
```

To avoid having to run as root, you can add the following rule to a file in `/etc/udev/rules.d`:
```
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", MODE:="0660", GROUP:="audio"
```

Then add the desired user to the `audio` group.
If you plugged in the RTL-SDR before installing rtl-sdr, you probably will need to do something like `sudo rmmod rtl2832 dvb_usb_rtl28xxu` then remove and reinstall the adapter.

### Configuration
Modify `mqtt_config.h` to specify the host, port, username, and password of your MQTT broker.  If `""` is used for the username or password, then an anonymous login is attempted.  Also, the payloads of some signals can be configured.

### Building
```
  cd src
  ./build.sh
```

### Running
  `./345toMqtt`

### MQTT Message Format

| **Topic**                                   | **Payload**         |
| /security/sensors345/sensor/<txid>/loop<N>  | OPEN or CLOSED      |
| /security/sensors345/sensor/<txid>/tamper   | TAMPER or OK        |
| /security/sensors345/sensor/<txid>/battery  | LOW or OK           |
| /security/sensors345/keypad/<txid>/keypress | 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, *, #, STAY, AWAY, FIRE, POLICE |
| /security/sensors345/keyfob/<txid>/keypress |  STAY, AWAY, DISARM, AUX |

