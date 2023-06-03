---
layout: post
title: "Build RDM from Source for Mac OS X"
date: 2018-06-19
author: Long Trieu
description: We can make the world better
permalink: /build-rdm-from-source-for-mac-os
---

# Build RDM from Source for Mac OS X

If you try to build RDM from Source Code for Mac OS X and could not make it work by following the http://docs.redisdesktop.com/en/latest/install/#build-from-source original Document, please try this:

### 1. Install Git

### 2. Get source code from Terminal

``` bash
$ mkdir RDM $ git clone --recursive
https://github.com/uglide/RedisDesktopManager.git -b 0.9 rdm
cd ./rdm
```

### 3. Install XCode

### 4. Install XCode build tools from Terminal

``` bash
$ sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

### 5. Install [Homebrew](https://brew.sh/) from Terminal

``` bash
$ /usr/bin/ruby -e "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew doctor
```

### 6. Navigate to source code folder and make Info config file

``` bash
$ cd src/resources
cp Info.plist.sample Info.plist
```

### 7. Build RDM dependencies

``` bash
$ cd src/resources
./configure
```

### 8. Install [Qt latest version](https://www.qt.io/download#section-2)

### 9. Open `/resource/rdm.pro` in Qt Creator

### 10. Run build

If you face any problem, please feel free to share and we can work together to solve it.

Thanks
