# [IMPORTANT] Security: How the Script Handles SUDO Passwords

As you know when running this scrupt in userspace, you are warned to enter your sudo password, i am sure that you are scared but don't panic, The script ain't going to save your sudo password (unless there's some software inside your system that are sniffing variables), look at `main.sh` source code

First: 

```
PASSKEY=$(dialog --backtitle "Enter Password" \
                --title "Enter Password for SUDO prompts"\
                --passwordbox "Enter SUDO password before continuing this session\n\nSee Security.md or the script's source for more info on how this script uses SUDO password\n\nOr just run the script back as sudo bash main.sh" 0 0 \
                2>&1 >/dev/tty)
```

Dialog is the one who will display the password while bash is the one keeping the entered passwords

Two:

```
if [ -z $PASSKEY ]; then 
        export DIALOGRC="scheme/error.thm"
        dialog --backtitle "ERROR" --title "Blank Password" --msgbox "The password you entered is blank..." 0 0
        unset DIALOGRC
        exit 1
```

If you notice this, its an if expression that blocks the continuation if the variable was empty, this is to ensure that the script wont start easily, but take a look at this!

Third:

```
unset PASSKEY
```

The script flushes the variable as soon as possible to ensure that its gone immediately after in contact with `sudo`

And you can see multiple of these `unset PASSKEY` from `line 14` to `line 62` (As of Version 0.1)

So now you know...