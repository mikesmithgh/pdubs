# pdubs
pdubs is a simple command-line utility to return macos window information for a given pid. If a given pid does not have an associated window, then it will check all of its ancestors. The window information for the first pid that is associated will be returned. The window information is a list in json format.

You may supply one optional parameter providing the pid. If no parameter is provided, then it will search for the current processes pid.

## swift commands

### debug build
```sh
swift build
```

### release build
```sh
swift build -c release
```

### run
```sh
swift run
```

## usage examples

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

