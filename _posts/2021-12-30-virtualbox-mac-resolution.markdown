---
layout: post
title: "A Fix for Virtualbox HiDPI Issues on MacOS"
date: 2021-12-30 18:51
---

Virtualbox has been troublesome on MacOS for a number of years now, due to issues with its support for high resolution displays, like the Retina ones that Macs have had for a long time. If you install a fresh Ubuntu VM, you notice right away that you have a tiny display that is very difficult to read. So you then try adjusting the scaling factor setting in Virtualbox, only to find that the client OS has become very laggy to use. Opening the Activities view in GNOME moves like a slideshow, and even dragging a window around results in unusably slow repainting.

Finally, I found [a trick that works reliably.](https://forums.virtualbox.org/viewtopic.php?f=8&t=90446&p=473464&hilit=slow)

> 1. Navigate to Apps folder. Choose VirtualBox.app
> 2. Right click on VirtualBox.app, Show Package Contents.
> 3. Contents -> Resources -> VirtualBoxVM.app (right click -> Get info)
> 4. Check the "Open in Low Resolution" checkbox.
> 5. Run the Virtual Machine in 100% scale mode.

The VM will be correctly sized, and won't have the excessive repainting lag. This doesn't fix issues with 3D applications (such as RViz and Gazebo, for Robot Operating System) being incredibly slow, as that's a different issue, but it's a huge step in the right direction.