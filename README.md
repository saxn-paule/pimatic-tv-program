This plugin provides the tv program for the current day. It shows the tv program for now, 20:15 and 22:00 o'clock.

# Configuration
There are different configuration parameters
* time - Which program do you want to get? could be "now", "20:15" or "22:00"
* short - If set to true, pictures and descriptions aren't shown
* stations - Which stations should be shown. Default ist "all". Possible entries are: all, Das Erste, ZDF, RTL, SAT.1, ProSieben, kabel eins, RTL II, VOX, 3sat, ARTE, ZDFneo, NITRO, DMAX, sixx, SAT.1 Gold, ProSieben MAXX, SUPER RTL, TELE 5


### Sample Device Config:
```javascript
    {
      "id": "tv-program",
      "name": "TV Programm",
      "class": "TvProgramDevice",
      "time": "20:15",
      "short": false,
      "stations": "all"
    },
```

# Beware
This plugin is in an early alpha stadium and you use it on your own risk.
I'm not responsible for any possible damages that occur on your health, hard- or software.

# License
MIT
