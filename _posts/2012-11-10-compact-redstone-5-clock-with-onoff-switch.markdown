---
author: redwall_hp
comments: true
date: 2012-11-10 19:58:51
layout: post
slug: compact-redstone-5-clock-with-onoff-switch
title: Compact Redstone 5-Clock with On/Off Switch
wordpress_id: 242
categories:
- Entertainment
tags:
- gaming
- Minecraft
---

{% img right /images/posts/minecraft-standard5clock.png %}
If you need a redstone current to turn on and off in slow pulses, such as in my recent [Minecraft Lighthouse](http://matt.harzewski.com/2012/11/10/minecraft-lighthouse/) project or for some piston contraption, the 5-clock is the go-to circuit for the job. Usually it looks something like the diagram pictured to the right, taking up a fairly large amount of space for the desired five-tick pulse cycle.

Another method, which takes up a bit less space, uses redstone repeaters wired up in a circle, much to the same effect. Thanks to the adjustable delay on repeaters, as well as their current-extending properties, you can pretty much add additional repeaters on to create whatever delay you want.

After making the aforementioned lighthouse with a repeater clock, I wanted to add a switch so it could be toggled off and on at will. I came up with the modification shown below. When the switch is in the upward position, it kicks out the initial signal to start the clock, and it can keep looping, passing through the block each time. If you flip the switch, it becomes an OR gate and forces the loop to stop. The output wire, which leads to the lamp on the lighthouse, could be hooked up to any of the redstone wires.

{% img /images/posts/minecraft-compact5clock-switch.jpg %}
