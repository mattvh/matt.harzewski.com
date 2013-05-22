---
author: redwall_hp
comments: true
date: 2013-04-26 15:21:00
layout: post
slug: looking-for-add-apt-repository-in-ubuntu-12-04-it-moved
title: Looking for add-apt-repository in Ubuntu 12.04+? It Moved
wordpress_id: 285
categories:
- Development
tags:
- NGINX
- Ubuntu
---

I was trying to upgrade [NGINX](http://nginx.org/en/) on an Ubuntu 12.04 box today. Preferring to use APT and be a _little bit_ behind the bleeding edge, rather than having to deal with the hassle of compiling from source, I wanted to [add the](http://blog.bigdinosaur.org/nginx-dev-or-stable/) `nginx/development` [PPA](https://launchpad.net/nginx). (NGINX's development branch is reliable enough for production usage, the development branch merely being subject to more frequent changes.)

When I went to add the PPA with `add-apt-repository`, I was met with a "command not found" error. This is a well-documented issue, where the command isn't installed by default, and has to be added by downloading the `python-software-properties` package. To my surprise, it didn't work. I spent about a quarter hour searching for a reason why, but pretty much every page said "just install `python-software-properties`." Yeah, I already tried that.

I ended up using `apt-file search` to discover where `add-apt-repository` is supposed to reside.

_Apparently_, it was moved somewhere along the line. Instead of being in `python-software-properties`, `add-apt-repository` is now a part of `software-properties-common`. So if you want to install `add-apt-repository` for your PPA needs, you just need to apt-get install `software-properties-common`.
