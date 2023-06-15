---
title: "Android Battery Information from File system"
date: 2013-04-08
author: Long Trieu
description: We can make the world better
permalink: /android-battery-information-from-file-system
---

# Android Better information from File System

Today, I’d like to take a dive into some technical specifics. This isn’t for everyone, but I think some people– mostly Android developers!– will find it useful.

In Linux, applications collect the battery status through sysfs, where the battery status is located in `/sys/class/power_supply/`. Different platforms, however, may give us a different directory layout under `/sys/class/power_supply/`, but Android hardcodes the directory layout to `/sys/class/power_supply/`. From the directory `/sys/class/power_supply/battery/`, there is some files that contains the newest information about the real battery:

### 1. uevent:
Contains some information including: name, type, status, health, present, technology, capacity, for example:

``` bash
POWER_SUPPLY_NAME=battery POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_STATUS=Charging POWER_SUPPLY_HEALTH=Good
POWER_SUPPLY_PRESENT=1 POWER_SUPPLY_TECHNOLOGY=Li-ion
POWER_SUPPLY_CAPACITY=93
```

### 2. batt_vol:
Contains the information about the current voltage of the battery: for example, 417

### 3. batt_temp:
Contains the information about the current temperature of the battery: for example, 310

So, we can access to that directory, read those related files and get the appropriate information about the battery.
