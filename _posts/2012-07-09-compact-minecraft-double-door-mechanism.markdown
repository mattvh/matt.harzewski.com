---
author: redwall_hp
comments: true
date: 2012-07-09 19:53:15
layout: post
slug: compact-minecraft-double-door-mechanism
title: Compact Minecraft Double-Door Mechanism
wordpress_id: 212
categories:
- Entertainment
tags:
- Minecraft
---

If you're playing Minecraft on a server that encourages PvP, it's kind of important to have some form of security mechanism. Otherwise you'll be considered an easy target, and players will constantly try to kill you.

{% img right /images/posts/mcdoubledoors-preview.jpg %}
The most common deterrent is to simply use iron doors, with a lever on the inside to open and close them, instead of simple wooden doors. However, anyone who's tried to set up _double-doors_ that open at the flip of a single switch, knows just how irritating it is. You need to have a redstone circuit that applies power to both doors at once, and those circuits often take up too much room. Unless you planned your base to have an outer wall and an exterior wall, with a large gap between them, you might be stuck having exposed redstone paraphernalia.

Since I don't like having exposed wiring, I figured out a method of making a compact double-door mechanism that won't require you to butcher your nice building to make it work.<!-- more -->

This is what it looks like from below.

{% img /images/posts/mcdoubledoors-bottom-700x437.png %}

I bet that got your attention. That ensures that both doors open and close at the pull of the lever, while using _far_ less space than what you'd find in most YouTube tutorials. The mechanism fits into a single row of blocks.

Of course, there are two layers of blocks involved here. The row that contains the mechanism and door is technically that one block-thick wall I was talking about earlier, but there's a big stone staircase on the outside of the tower that conveniently covers it up. So I lucked out and had a two block-thick wall in this case.

{% img /images/posts/mcdoubledoors-vbottom-700x437.png %}

You can see how it works a little better in this shot. The two dirt blocks have a single piece of redstone wire on top, with two repeaters in the middle. The left one brings the current down from the switch, the repeaters carry it over to the next block, which carries it back up to the second door. The switch is next to the left door, so it opens it simply by being in proximity. (Ignore the blank space on the bottom row of stone, I accidentally mined it.)

In the view from above, you can see the little dots of redstone wire on the dirt blocks. The one on the right is close enough to power the right-side door, and the lever sends power directly to the left door, as well as downward to the repeaters.

{% img /images/posts/mcdoubledoors-vtop-700x437.png %}

It's an elegant solution, if you don't mind a tiny repeater lag before the second door is triggered, and simple enough once you have it figured out.
