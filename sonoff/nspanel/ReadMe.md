# Flashing the NS Panel with ESPhome

## For flashing we use esptool from command line but other tools do also work

## Backup the NS panel config

Run esptool.py flash_id to read the content of the ESP32 chip

This will return something like

  ```  
  Detecting chip type... ESP32
  Chip is ESP32-D0WD-V3 (revision v3.0)
  Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, Coding Scheme None
  Crystal is 40MHz
  MAC: c0:49:ef:f9:bd:34
  Stub is already running. No upload is necessary.
  Manufacturer: 5e
  Device: 4016
  Detected flash size: 4MB
  ```

Backup the original firmware:

  ```
  esptool.py -b 115200 --port /dev/cu.usbserial-0001 read_flash 0x00000 0x400000 nspanel_original.bin
  ```

## Flash the NS Panel with code to work with ESPhome

There might be many respositories available that will work but our prefered solution is the repository from [Johannes(joBr99)](https://github.com/joBr99/nspanel-lovelace-ui).
It is in our opinion the most versatile addon with a lot of options and possibilities to configure. It might be a bit tricky to set it up since it requires the Appdaemon add-on but once you have it up and running it is very easy to change and add the content of the NSPanel.

The changed the proposed code a bit. It will create a Hotspot with the ssid "snjallingur" (password is the same) to allow an easy setup for others.

Before flashing make sure to erase the flash

  ```
  esptool.py erase_flash
  ```

Then flash the NSPanel with your yaml code. You can use the sample code ```esphome.yaml```, but don't forget to adopt the names and passwords according to your environment.

  ```
  esphome run esphome.yaml
  ```

when esphome has finished compiling your binary file that will be flashed on your NS Panel, it will ask you to determine how to connect to your NS Panel (through a serial connection connected to your computer or to transmit the files over the air with your WiFi connection). 

or when using esptools for flashing you could leverage a command like:

  ```
  esptool.py -p /dev/cu.usbserial-0001 -b 460800 --before default_reset --after hard_reset --chip esp32  write_flash --flash_mode dio --flash_size detect --flash_freq 40m   0x1000 bootloader.bin 0x8000 partitions.bin 0x10000 nspanel-firmware.bin
  ```

the esptool offers a lot more options for compiling and is therefore more flexible but also more complicated. Further references on the available options can be [found here](https://docs.espressif.com/projects/esptool/en/latest/esp32/esptool/flashing-firmware.html#flashing).

## Connect the NSPanel to your network

After the flashing of the firmware above and repowering the NSPanel you will first off notice **NO** difference. The panel will start up with the Sonoff logo and will prompt you to connect the panel to your eWeLink app. When you used the yaml code provided in this repository you will notice that the NSPanel will create an WiFi AP with the ssid of *snjallingur*. The password to connect to this network is also *snjallingur*. After you connect to this network with your phone or laptop you are redirected to a page where you can specify the network ssid of your network. After entering your passworf the NSPanel will try to connect to your network. Once connected you will notice the device on your network.

## Connect the NSPanel to Home Assistant

From the integrations page select the *ESP Home* integration. When prompted enter the IP address of your NS Panel.

## Flash the Nextion firmware

Finally upload the nextion display firmware to the NS Panel. The service to be used is *esphome.<yourNSPanelname>_upload_tft*

  ```
  service: esphome.snjallingur_nspanel_upload_tft
  data:
    url: http://nspanel.pky.eu/lui-release.tft
  ```




