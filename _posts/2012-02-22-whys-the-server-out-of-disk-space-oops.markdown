---
author: redwall_hp
comments: true
date: 2012-02-22 21:55:50
layout: post
slug: whys-the-server-out-of-disk-space-oops
title: Why's the Server Out of Disk Space? Oops.
wordpress_id: 95
categories:
- Misc
tags:
- geek
- Linux
- Minecraft
- server
---

I have one web server (a VM from [VPS.net](http://vps.net/)) that hosts all of my various web sites. Nothing too intensive, mostly WordPress blogs and some custom PHP applications. Maybe a Python script or two.

Earlier, my brother alerted me to the fact that my MySQL daemon was AWOL, when he tried to visit one of the sites and got an error message. So I fired up a terminal and went to take a look. After trying to restart the `mysqld` process with no success, I eventually thought to check the disk space. _Somehow_, the 20GB volume was full. It didn't make much sense, seeing as I wasn't storing any large media files or anything...

Upon closer inspection, I found that there was one 12GB directory that was full of large [Minecraft](http://www.minecraft.net/) world backups. :)

{% img /images/posts/minecraft-cron-goes-crazy.png %}

<!-- more -->I operate a private Minecraft server for my brothers and I, and I have a cron job that automatically backs it up on a daily basis. The backups get dumped to my web server for safekeeping, and are _supposed_ to be deleted after a few days. There should never be more than a few days worth of world backups, but the backup script wasn't deleting anything. So there ended up being months worth of large (well over 100MB apiece) archives. Oops.

For future reference, here's a handy command worth remembering:

`sudo du -hs /*`

You can replace `/` with any path you want to get the size of its subdirectories.
