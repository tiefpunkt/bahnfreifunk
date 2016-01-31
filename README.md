# Bahn Freifunk Image Builder
## What is Bahn Freifunk?
The german rail company "Deutsche Bahn" has free wifi internet access in the first class coaches of their ICE trains. The intention of Bahn Freifunk is to easily share this free internet access with passengers in second class coaches.

If think that's cool, but you don't want to do all this script and building stuff, there are ready made images over at https://wiki.munichmakerlab.de/wiki/Bahn_Freifunk

## What does the stuff in this repository do?
This repository contains two scripts and a bunch of configuration required to achieve the above, and it allows you to build your own firmware for Bahn Freifunk.

## Supported hardware
In theory, any hardware that runs OpenWRT is supported.

In practice, this has only been tested on a single piece of hardware, a TP-Link TL-MR3020, with a LOGILINK WL0151 USB WiFi dongle as secondary wifi interface. It should also work with any other ar71xx OpenWRT device (as long as it has a USB port) and any other RT5370 based USB wifi dongle.

## How to use it
If you have the exact hardware combination, you can just run the ./build.sh script from this folder. It will download the OpenWRT image builder into a subdirectory and then build the image.

You can also change the image builder profile in the script and build for other devices.

Lastly, you can just copy the files directory into your own image building process, and do whatever you feel like with it.

Once you have created the image, please make sure to check out https://wiki.munichmakerlab.de/wiki/Bahn_Freifunk for more information on how to flash it and what todo after you have done so.

## ATTENTION: Big Bad Surveillance happening
If you don't go through the files, I'll just tell you here: One of the scripts sends the current status of your Bahn Freifunk node to my server. I do this on my node because I want to see how it's being used. I'd be grateful if you do the same. If you don't like to do that, that's fine with me as well (just remove the line from files/etc/crontabs/root). It would be great if you could tell me how it's being used nonetheless, I'm just curious like that.

As of writing this, the data transmitted contains the train number, number of connected wifi clients, and the amount of data being sent over the WAN interface. I'm planning to make some nice statistics out of that eventually.
