---
author: redwall_hp
comments: true
date: 2009-03-29 19:00:38
layout: post
slug: undefined-functions-in-object-oriented-php
title: Undefined Functions in Object-Oriented PHP
wordpress_id: 29
categories:
- Technology
tags:
- php
---

Just had a big "duh" moment.

Have you ever had a PHP method (a function inside a class, in case you're new to the whole OOP thing) cause a `"Fatal Error: Call to undefined function 'whatever'..."` *even though you are 100% sure that the method has been defined?*

You're missing the `$this->` before your call to the method. :P
