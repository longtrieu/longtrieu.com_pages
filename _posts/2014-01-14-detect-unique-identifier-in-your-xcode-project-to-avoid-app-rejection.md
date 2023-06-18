---
title: "Detect uniqueIdentifier in your Xcode project to avoid App Rejection"
date: 2014-01-14
author: Long Trieu
description: We can make the world better
permalink: /detect-unique-identifier-in-your-xcode-project-to-avoid-app-rejection
---

### Detect uniqueIdentifier in your Xcode project to avoid App Rejection

As you know, `uniqueIdentifier` is deprecated and now Apple will reject all apps that use the `uniqueIdentifier`. You can avoid using the `uniqueIdentifier` by your code, but a very simple problem is that: What if some frameworks/libraries that you're integrating into your project use the `uniqueIdentifier`?

One very simple answer is to navigate into your project folder on `Terminal` and gracefully type this:

``` bash
$ grep -Rnis 'uniqueIdentifier' *
```

It will show you frameworks/libraries that are using the `uniqueIdentifier`, just like this:

``` bash
Binary file Revmob/RevMobAds.framework/RevMobAds matches
Binary fileRevmob/RevMobAds.framework/Versions/A/RevMobAds matches
Binary file Revmob/RevMobAds.framework/Versions/Current/RevMobAds matches
```

You can either update your frameworks/libraries to the newer version (it should fix the problem of using the `uniqueIdentifier`) or contact the developers.

Then, happy coding!
