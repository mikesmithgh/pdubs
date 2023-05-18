# 🦬 pdubs
pdubs is a simple command-line utility to return macos window information for a given pid. If a given pid does not have an associated window, then it will check all of its ancestors. The window information for the first pid that is associated will be returned. The window information is a list in JSON format.

You may supply one optional parameter providing the pid. If no parameter is provided, then it will search for the current processes pid.

## 🤔 Motivation
I wanted an easy way to get the window ID of my current process so that I could take a screenshot from the command-line with [screencapture](https://ss64.com/osx/screencapture.html).  
### screenshot example
```bash
win=$(./pdubs | jq .[0].kCGWindowNumber); screencapture -l"$win" pdubs.png
```
![pdubs](https://github.com/mikesmithgh/pdubs/assets/10135646/5e389586-717a-4f60-9f59-30a40eea1548)

## 📦 Installation

### Download the binary for your system
```sh
curl --silent --fail --location --output pdubs.tar.gz https://github.com/mikesmithgh/pdubs/releases/latest/download/pdubs.tar.gz
curl --silent --fail --location --output pdubs.tar.gz.sha256 https://github.com/mikesmithgh/pdubs/releases/latest/download/pdubs.tar.gz.sha256
if shasum -c pdubs.tar.gz.sha256; then 
  tar -xvf pdubs.tar.gz 
else
  rm pdubs.tar.gz
fi
```
Move the binary `pdubs` to the desired location and place on your `$PATH`

For example,
```sh
mv pdubs ~/bin
```

## 🍎 Supported OS versions
- macOS 13 Ventura
- macOS 12 Monterey
- macOS 11 Big Sur

## 🔨 Swift commands

### debug build
```sh
swift build
```

### release build
```sh
swift build -c release --arch arm64 --arch x86_64
cd .build/apple/Products/Release || exit 1
tar -czvf pdubs.tar.gz pdubs
shasum --algorithm 256 pdubs.tar.gz | tee pdubs.tar.gz.sha256
```

### run
```sh
swift run
```

## 👩‍💻 Usage examples

### current process
```sh
./pdubs
```
```json
[
  {
    "kCGWindowName" : "./pdubs",
    "kCGWindowStoreType" : 1,
    "kCGWindowOwnerName" : "kitty",
    "kCGWindowAlpha" : 1,
    "kCGWindowSharingState" : 1,
    "kCGWindowBounds" : {
      "X" : 3440,
      "Height" : 1055,
      "Y" : 385,
      "Width" : 1920
    },
    "kCGWindowIsOnscreen" : true,
    "kCGWindowOwnerPID" : 57175,
    "kCGWindowNumber" : 9382,
    "kCGWindowMemoryUsage" : 2288,
    "kCGWindowLayer" : 0
  },
  {
    "kCGWindowStoreType" : 1,
    "kCGWindowName" : "vi README.md ",
    "kCGWindowLayer" : 0,
    "kCGWindowOwnerName" : "kitty",
    "kCGWindowOwnerPID" : 57175,
    "kCGWindowMemoryUsage" : 2288,
    "kCGWindowNumber" : 9432,
    "kCGWindowSharingState" : 1,
    "kCGWindowIsOnscreen" : true,
    "kCGWindowAlpha" : 1,
    "kCGWindowBounds" : {
      "X" : 1720,
      "Height" : 1415,
      "Y" : 25,
      "Width" : 1720
    }
  }
]
```

### target process
```sh
./pdubs 62556
```
```json
[
  {
    "kCGWindowStoreType" : 1,
    "kCGWindowNumber" : 9422,
    "kCGWindowAlpha" : 1,
    "kCGWindowBounds" : {
      "X" : 0,
      "Height" : 1415,
      "Y" : 25,
      "Width" : 1720
    },
    "kCGWindowMemoryUsage" : 2288,
    "kCGWindowOwnerPID" : 62553,
    "kCGWindowLayer" : 0,
    "kCGWindowSharingState" : 1,
    "kCGWindowName" : "-bash",
    "kCGWindowIsOnscreen" : true,
    "kCGWindowOwnerName" : "iTerm2"
  }
]
```

## 🕵️ Troubleshooting

### Developer cannot be verified warning
```
"pdubs" cannot be opened because the developer cannot be verified.
```
If you receive the warning message while trying to execute pdubs, this is most likely because you manually downloaded the file from the release page. Depending on your download method, Apple will quarantine an app if it is not by an identified developer. I do not have an Apple developer account which is why you will see this warning.

Before removing the app from quarantine, please verify the checksum has not been changed with the `shasum` command. If this fails, then delete and download pdubs from the release page.
```sh
shasum -c pdubs.tar.gz.sha256
```

You can manually resolves the quarantine by control-clicking and opening the application from Finder or via the following command.
```sh
xattr -d com.apple.quarantine pdubs
```
See [What should I do about com.apple.quarantine?](https://superuser.com/questions/28384/what-should-i-do-about-com-apple-quarantine) for additional information.
