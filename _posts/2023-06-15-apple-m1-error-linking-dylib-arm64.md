---
title: "Apple M1 Error linking in dylib build, file for arm64"
date: 2023-06-15
author: Long Trieu
description: We can make the world better
permalink: /apple-m1-error-linking-dylib-arm64
---

# Error: "Building for iOS Simulator, but linking in dylib built for iOS, file '...' for architecture arm64"

If you face this problem while trying to run Xcode project on the iOS Simulator, please try the solution below:

### 1. Exclude `arm4` from Architectures

![Exclude Architectures](/docs/assets/exclude-architecture.png)

- Simply edit each type (Debug, Profile, Release), and click + to add `arm64` to the current list

### 2. Exclude `arm64` from your Pods

- Open your `Podfile` and add this to exclude `arm64` from all of your current Pods:

``` bash
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
```

- Then run this to update your Pods

``` bash
$ pod install
```

### (Optional) 3. Define your libraries as `Optional`

![Optional Libraries](/docs/assets/make-framework-optional.png)

- Consider marking some of your libraries as `Optional` if you're sure they won't run well on the iOS Simulator

### (Optional) 4. Use pre-defined macro to split your code flow

- Use these macros to split your source code between Simulator and actual iPhone during runtime:

``` objective-c
#if TARGET_IPHONE_SIMULATOR
  // Don't use framework
  ...
#else
  // Use framework
  ...
#endif
```

``` swift
#if targetenvironment(simulator)
  // Don't use framework
  ...
#else
  // Use framework
  ...
#endif
```

I hope that this helps

Happy debugging :)
