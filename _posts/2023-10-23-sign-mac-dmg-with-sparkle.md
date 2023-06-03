---
layout: post
title: "Sign Mac Dmg with Sparkle"
date: 2023-10-23
author: Long Trieu
description: We can make the world better
permalink: /sign-mac-dmg-with-sparkle
---

# Sign your Mac app with Sparkle and handle Auto-download and update

### 1. Sign and Archive your Mac app with Xcode > Developer Id

### 2. Upload new `dmg` to a https-empowered server

### 3. Update new Appcast

- Generate your `appcast.xml` file:

``` bash
$ ./bin/generate_appcast <path-to-your-app-holding-folder>
```

- Update your `appcast.xml` file with correct value for these tags:

```
<title>                         // Version title
<sparkle:releaseNotesLink>      // Link to the short HTML file of changelog
<sparkle:fullReleaseNotesLink>  // Link to the full HTML file of changelog (can use same file)
<enclosure url="...">           // Link to the actual dmg on the https-empowered server
```

- Enjoy the automatic update alert for your app!