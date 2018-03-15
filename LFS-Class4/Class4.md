# Linux From Scratch - 4

---

# Speakers

----

# Aditya Kamat

* CSE @ BMSCE
* [Linkedin](https://www.linkedin.com/in/aditya-kamat-53646310b/)
* [Github](https://github.com/GiVeMeRoOt)
* Twitter (@kamat_adi)

----

# Kaushik Iyer

* ISE @ BMSCE
* Update anything more you want to put here

---

## Table of contents:
* GUI architecture
* Introduction to xorg
* Openbox
* Adding new UI elements

---

GUI architecture

----

There are basically three layers that can be included in the Linux desktop:
* X windows
* Window Manager
* Desktop Environment

----

## X Windows

This is the foundation that allows for graphic elements to be drawn on the display. X Windows builds the primitive framework that allows moving of windows, interactions with keyboard and mouse, and draws windows. This is required for any graphical desktop.

----

## Window Manager

The Window Manager is the piece of the puzzle that controls the placement and appearance of windows. Window Managers include: Enlightenment, Afterstep, FVWM, Fluxbox, IceWM, etc. Requires X Windows but not a desktop environment.

----

## Desktop Environment

This is where it begins to get a little fuzzy for some. A Desktop Environment includes a Window Manager but builds upon it. The Desktop Environment typically is a far more fully integrated system than a Window Manager. Requires both X Windows and a Window Manager. Examples of desktop environments are GNOME, KDE, Cinnamon, Xfce among others)

---

# Introduction to xorg

----

`X.Org Server is the free and open source implementation of the display server for the X Window System stewarded by the X.Org Foundation. Implementations of the client side of the protocol are available e.g. in the form of Xlib and XCB`

----

LightDM

----

It is an open source X Display manager that was introduced with Arch Linux.
To install it we run:

> `sudo apt install lightdm`

---

# Openbox

> `sudo apt install openbox`
> `sudo apt install openbox-gnome-session`
> `sudo apt install obmenu`

----

styling the terminal and the menu

> `sudo apt install gnome-terminal`

----

to install and create your own .obt files.
[look here](http://openbox.org/wiki/Help:Themes)

---

# Adding new UI elements

----

`<openbox_menu xmlns="http://openbox.org/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://openbox.org/">
    <menu id="root-menu" label="obmenu-generator" execute="/usr/bin/perl /usr/bin/obmenu-generator -i" />
</openbox_menu>`

----

Creating a new menu item

----

Creating a new Panel

> `sudo apt install tint2`

----

Creating a Dock

> `sudo apt install docky`

----

Adding some nice backgrounds

> `sudo apt install nitrogen`

To remember our last used wallpaper we run

> 'nitrogen --restore &'

----

but we don't have any yet

----

> `sudo apt install ubuntu-wallpapers`

----

Adding a file manager

> `sudo apt install pcmanfm`

----

Adding an icon pack

> `sudo apt install lxappearance`
----

Adding opacity and fluidic motion to the UI

> `sudo apt install xcompmgr`

----

Adding a task manager

> `sudo apt install lxtask`

---

THANK YOU
