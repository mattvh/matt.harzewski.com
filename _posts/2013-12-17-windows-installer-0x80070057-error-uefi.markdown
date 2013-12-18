---
layout: post
title: "Is the Windows Installer Throwing a 0x80070057 Error and Failing to Format Partitions? Are You Using a UEFI?"
date: 2013-12-17 22:11
---

I was recently trying to install Windows 8.1 on a freshly-built computer, and I discovered a little requirement that those of us who are new to UEFI motherboards may not be aware of...

Everything was going fine, all the way up to the step where you partition and format the drive, but the installer wouldn't proceed with the installation. It would throw a 0x80070057 error whenever I clicked Next and it started trying to format the partitions the installer created.

As it turns out, newer motherboards that use UEFI—instead of the older BIOS standard—have a minor consideration you need to take into account when setting the boot order. Usually, you would set the BIOS to boot from the CD/DVD drive before the hard drive, so the installer can run. With a UEFI, you need to look for an option that reads something along the lines of **UEFI: ASUS DVD-RW Drive**. That "UEFI" prefix means it will boot in UEFI mode, rather than in legacy BIOS mode.

Fix that, and it should work perfectly.

Of course, I ran into further (unrelated) issues. The brand-new hard drive failed when the installation process was at the 50% mark. (It was a textbook case. You could hear the rhythmic clicking of the drive head constantly resetting itself, and it would intermittently vanish from the UEFI menu.)
