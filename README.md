# AltServer-Linux-ShellScript

Works on debian 11 x64 !!

And works on pinephone (tested on mobian)

Demo videos at the bottom

AltServer from https://github.com/NyaMisty/AltServer-Linux/releases

## Note 
AltStore installation avaliable,run with `./install.sh`

And you can refresh apps with AltServer in daemon mode,run `./daemon.sh`

***Not work on every linux distribution and architectures,report issues to [issues](https://github.com/powenn/AltServer-Linux-ShellScript/issues)***

![photo][0]

## Get start
`get setup.sh`
```
wget https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/setup.sh && chmod +x setup.sh
```
run `./setup.sh`

You need idevicemobile

`apt setup dependencies`
```
sudo apt-get install usbmuxd libimobiledevice6 libimobiledevice-utils
```

Please storage your ipa files into AltServer/ipa

To install your ipa ,just run `./start.sh` and follow the instruction
![photo][1]
![photo][2]
![photo][3]

### Video(install AltStore)

<a href="https://www.youtube.com/watch?v=eraWIbdxyOo">
  <img src="https://img.youtube.com/vi/eraWIbdxyOo/maxresdefault.jpg" >
</a>

<a href="https://www.youtube.com/watch?v=57JDy2GX1JY">
  <img src="https://img.youtube.com/vi/57JDy2GX1JY/maxresdefault.jpg" >
</a>

### Video(install ipa)

<a href="https://www.youtube.com/watch?v=AgqoaBQd_p8">
  <img src="https://img.youtube.com/vi/AgqoaBQd_p8/maxresdefault.jpg" >
</a>



[0]:https://github.com/powenn/AltServer-Linux-ShellScript/blob/main/photos/00.jpg
[1]:https://github.com/powenn/AltServer-Linux-ShellScript/blob/main/photos/01.jpg
[2]:https://github.com/powenn/AltServer-Linux-ShellScript/blob/main/photos/02.jpg
[3]:https://github.com/powenn/AltServer-Linux-ShellScript/blob/main/photos/03.jpg
