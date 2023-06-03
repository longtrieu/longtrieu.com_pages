---
layout: post
title: "Build your own Private Pod"
date: 2020-12-23
author: Long Trieu
description: We can make the world better
permalink: /build-your-own-private-pod
---

# Build your own Private Pod to use internally inside your company / team

Cocoapods is quite familiar to iOS Developer, and you (may) have been using it for years but mostly to integrate 3rd party libraries or frameworks. Have you ever wondered if you can use Cocoapods to host your personal / private library for internal use? It has some benefits:
- Encapsulate your core library code to avoid unwanted changes.
- Avoid pushing and pulling the whole framework to GitHub, it's quite heavy and slow (you may even need to use GitHub Large File for this)
- It looks more professional :)

So, let's get into this:

### 1. Prepare repositories

You will need 2 GitHub repositories for this:

- The 1st repository to host your Podspec, let call it:

``` bash
https://github.com/username/Your_Private_Pod_Podspec.git
```

- The 2nd repository to host your actual library code, let call it:

``` bash
https://github.com/username/Your_Private_Pod_Library.git
```

### 2. Install CocoaPods

``` bash
$ sudo gem install cocoapods
```
   
### 3. Register Podspec repository

Navigate to `Your_Private_Pod_Podspec` folder and add the Podspec

``` bash
$ cd Your_Private_Pod_Podspec
$ pod repo add YourPrivatePodSpec git@github.com:username/Your_Private_Pod_Podspec.git
```

### 4. Test Podspec repository
   
``` bash
$ cd ~/.cocoapods/repos/YourPrivatePodSpec
$ pod repo lint .
```
   
### 5. Create new Private Pod Project

Navigate to `Your_Private_Pod_Library` folder and add the Pod

``` bash
$ cd Your_Private_Pod_Library
$ pod lib create YourPrivatePod
```
   
### 6. Add your source code

Navigate to `YourPrivatePod/Classes` folder, it already had the file named `ReplaceMe.swift`. Delete this file and add your own source codes here.

### 7. Add your resources

Navigate to `YourPrivatePod/Assets` folder. Put your resource files here.

### 8. Make changes to `YourPrivatePod.podspec`

Follow this example

``` ruby
#
# Be sure to run `pod lib lint YourPrivatePod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YourPrivatePod'
  s.version          = '1.0.0'
  s.summary          = 'Your Private Pod Library.'
  s.description      = <<-DESC
                        Your Private Pod Library:
                        - Models
                        - Assets
                        - API Handler
                        - Delegate...
                       DESC

  s.homepage         = 'https://github.com/username'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Long Trieu' => 'your_email@somemail.com' }
  s.source           = { :git => 'git@github.com:username/Your_Private_Pod_Library.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version    = '4.0'
  
  # Resource assets
  s.subspec 'Assets' do |ss|
    ss.resources = 'YourPrivatePod/Assets/**/*'
  end
  
  # Source files
  s.subspec 'Classes' do |ss|
    ss.source_files = 'YourPrivatePod/Classes/**/*.{swift,storyboard,xib}'
    ss.resources = 'YourPrivatePod/Databases/*.{xcdatamodeld}'
  end

  # Resource bundles
  s.resource_bundles = {
    'YourPrivatePod' => ['YourPrivatePod/Classes/**/*.{storyboard,xib,strings,plist,ttf,xcdatamodeld,json}']
  }
  
  s.frameworks       = 'CoreData'
  
  # Other 3rd party Dependencies
  s.dependency         'CocoaLumberjack/Swift', '~> 3.7.0'
  s.dependency         'MBProgressHUD', '1.2.0'
  s.dependency         'SDCAlertView', '11.1.2'
  s.dependency         'Firebase/Firestore', '7.5.0'
  s.dependency         'Firebase/Core', '7.5.0'
  s.dependency         'Firebase/Messaging', '7.5.0'
end
```

### 9. Test your `YourPrivatePod.podspec`

``` bash
$ pod lib lint YourPrivatePod.podspec --allow-warnings
```
   
### 10. Push your Pod source code to GitHub

### 11. Tag your latest source code

Use the same version in your `YourPrivatePod.podspec`

``` bash
$ git tag '1.0.0'
$ git push --tags
```
  
### 12. Publish Private Pod to Podspec repository

``` bash
$ pod repo push YourPrivatePodSpec YourPrivatePod.podspec --verbose --allow-warnings
```
   
### 13. Update your Pod

Make changes to your source code and resources

Make changes to `YourPrivatePod.podspec` with new version

``` ruby
s.version          = '1.1.0'
```
    
Publish your new version like above (from step #8 to #11)

### 14. Release your Private Pod to use

Give other developers access to your `Your_Private_Pod_Podspec` repository only, remember that this repository only stores your Private Podspec and NOT your actual library code.

Then ask the developers to add this to their `Podfile` to use the Private Pod

``` bash
puts 'Fetch GitHub version from Podspec'
source 'git@github.com:username/Your_Private_Pod_Podspec.git'
source 'https://github.com/CocoaPods/Specs.git'
pod 'YourPrivatePod'
```

I hope this guide gave you a better overview of how to build your own Private Pod :)

Enjoy!
