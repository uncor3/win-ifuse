[![Build win-ifuse](https://github.com/uncor3/win-ifuse/actions/workflows/build.yml/badge.svg)](https://github.com/uncor3/win-ifuse/actions/workflows/build.yml)

## Win-ifuse a port of ifuse for Windows

[ifuse](https://github.com/libimobiledevice/ifuse) is a FUSE filesystem driver which allows you to mount iOS devices. This project is a port of ifuse to Windows using [WinFsp](https://github.com/winfsp/winfsp).

## Download

You can download the latest release from the [releases page](https://github.com/uncore/win-ifuse/releases).

[Latest Release](https://github.com/uncore/win-ifuse/releases/latest)

## Usage

Make sure to have AppleDeviceSupport drivers installed ( you can use this [script](https://github.com/NelloKudo/Apple-Mobile-Drivers-Installer)) and have your iphone paired (trust the computer), download from [releases](https://github.com/uncore/win-ifuse/releases), unzip , run the `install-win-fsp.bat` script as administrator once done open up a command prompt in the folder.

Run:

```
 win-ifuse.exe <mount-point>
```

🚨Important🚨 make sure the `<mount-point>` folder does not exist, this is the biggest difference between fuse and winfsp. Winfsp will create the mount point for you.

Example usage:

```
C:\Users\uncore\Downloads\win-ifuse-0.1.0>.\win-ifuse.exe C:\iphone

```

Bash Example:

```bash
win-ifuse.exe /c/iphone
```

## Building

You can follow the steps in the [GitHub Actions workflow](.github/workflows/build.yml).

## Licence

Same as [ifuse](https://github.com/libimobiledevice/ifuse), see [LICENSE](./COPYING)

## Thanks

- [libimobiledevice](https://www.libimobiledevice.org/)
- [WinFsp](https://github.com/winfsp/winfsp)
- [Authors](./AUTHORS)

## Contributing

Feel free to contribute. It's still in early development (beta)
