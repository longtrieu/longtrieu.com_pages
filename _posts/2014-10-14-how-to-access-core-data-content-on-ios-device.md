---
title: "How to access Core Data content on iOS device"
date: 2014-10-14
author: Long Trieu
description: We can make the world better
permalink: /how-to-access-core-data-content-on-ios-device
---

### How to access Core Data content on iOS device

Working with Core Data is sometimes painful because you can not read the content of your stored data. I found a remote debugger tool for your iOS development process called 'Pony Debugger'. The source code and tutorial can be found here: https://github.com/square/PonyDebugger

You can either use Cocoapods or Manually Installation to set up your Pony Debugger.

Then, in order to track your Core Data content, you can add these code into your iOS Client:

``` objective-c
PDDebugger *debugger = [PDDebugger defaultInstance];
[debugger enableCoreDataDebugging];
[debugger addManagedObjectContext:/*Your managed object context to track*/
withName:@"My MOC"];
[debugger connectToURL:[NSURL
URLWithString:@"ws://localhost:9000/device"]];
```

Please follow the Quick Start to install the Pony Debugger Gateway for tracking with these commands on your Terminal:

``` bash
curl -sk
https://cloud.github.com/downloads/square/PonyDebugger/bootstrap-ponyd.py
|
python - --ponyd-symlink=/usr/local/bin/ponyd ~/Library/PonyDebugger
ponyd serve --listen-interface=127.0.0.1
```

Now, you can open http://localhost:9000/ Gateway Dashboard ready.

Technically, there's a connection using Bonjour between your iOS Client and Pony Gateway server to help you read the content of your managed object context.

Then, happy debugging!
