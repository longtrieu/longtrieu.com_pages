---
title: "Create Drag App to /Applications dmg file"
date: 2023-06-23
author: Long Trieu
description: We can make the world better
permalink: /create-drag-app-to-applications-dmg-file
---

# Create Drag App to /Applications dmg file

If you develop Mac app but you don't want to release to the Mac App Store, maybe because you use some Private Libraries, Private APIs or you just simply don't want to go throught the review process. Then you can distribute your Mac app directly to customer's hand, there will be 2 kinds of dmg you can usually build:
- Package Installer (more complicated)
- Drag your App into /Applications folder

This guide will focus on the 2nd way with a few steps below

### 1. Export your Mac app to be notarized by Apple

Yes, even distributing without the Mac App Store, you still need to have an Apple Developer Account to notarize your Mac app (at the moment of writing this guide it still costs $99 per year). This notarization process will allow your Mac app to pass Gatekeeper verification at runtime and let your user know that your Mac app is safe to use.

Just a quick reminder, the process of notarization is not a review process:
- You still upload your app to Apple server but there will be no reviewer, and your app will be notarized automatically by bots / computers after just a few minutes.
- You can leave your app in `non-sandbox mode` (all apps submitted to the Mac App Store need to be `sandboxed`)
- You still need to enable `Hardener runtime` and sign your app with your Developer Id.

The result of this process will be `YourMacApp.app`

### 2. Create `icns` Icon for your `dmg`

[This answer](https://stackoverflow.com/questions/12306223/how-to-manually-create-icns-files-using-iconutil/20703594#20703594) is what you need to create the `icns` for your `dmg`, I will just note it again here for easy access

- Let create a folder to store all of the required file for this process, call it `YourMacAppFolder`

- You need to have an Icon file, let it be 1024x1024 for better display, and call it `icon_1024x1024.png`, place it under `YourMacAppFolder`

- Create your `iconset` folder:

``` bash
$ cd YourMacAppFolder
$ input_filepath="icon_1024x1024.png"
output_iconset_name="icon.iconset"
mkdir $output_iconset_name
```

- Generate your iconset files under this folder by using `sips`:

``` bash
$ sips -z 16 16     $input_filepath --out "${output_iconset_name}/icon_16x16.png"
$ sips -z 32 32     $input_filepath --out "${output_iconset_name}/icon_16x16@2x.png"
$ sips -z 32 32     $input_filepath --out "${output_iconset_name}/icon_32x32.png"
$ sips -z 64 64     $input_filepath --out "${output_iconset_name}/icon_32x32@2x.png"
$ sips -z 128 128   $input_filepath --out "${output_iconset_name}/icon_128x128.png"
$ sips -z 256 256   $input_filepath --out "${output_iconset_name}/icon_128x128@2x.png"
$ sips -z 256 256   $input_filepath --out "${output_iconset_name}/icon_256x256.png"
$ sips -z 512 512   $input_filepath --out "${output_iconset_name}/icon_256x256@2x.png"
$ sips -z 512 512   $input_filepath --out "${output_iconset_name}/icon_512x512.png"
```

- Generate your `icns` icon:

``` bash
$ iconutil -c icns $output_iconset_name
```

- [Optional] You can remove your `iconset` folder if you don't need it anymore:

``` bash
$ rm -R $output_iconset_name
```

### 3. Create your `dmg` file

We will use this handy tool [appdmg](https://github.com/LinusU/node-appdmg) to generate the `dmg` file

- You need to prepare a Background, let it be a 600x400 image file for example, and call it `background.png`

- You already have the `icon.icns` from the guide above

- Let make an alias of your `Applications` folder by right-click on it and choose `Make Alias`

- Let go back to your `YourMacAppFolder`, it should have these items inside:

``` bash
$ cd YourMacAppFolder
$ ls -a
background.png
icon.icns
YourMacApp.app
/Applications
```

- Now let make a new file called `config.json` with content below:

``` json
{
  "title": "Your Mac App Title",
  "icon": "icon.icns",
  "background": "background.png",
  "contents": [
    { "x": 173, "y": 194, "type": "file", "path": "YourMacApp.app" },
    { "x": 448, "y": 189, "type": "link", "path": "/Applications" }
  ],
  "window": {
    "size": {
      "width": 600,
      "height": 400
    }
  }
}
```

- Finally, run this to generate your `dmg` file:

``` bash
$ appdmg config.json YourMacApp.dmg
```

Now let's share your amazing `dmg` with your customers and let them use your amazing Mac app :)
