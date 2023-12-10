# Onlyoffice Installer

Install Onlyoffice using a script

If you are looking for Security.md, [here](/security.md)

**NOTE**: The script requires access to root to continue, and please check your previleges to continue

The Script uses Flatpak as a Backend since onlyoffice postinstalls are usually broken and i made this because the issue has been like this since! and Flatpak has 0% Problem

```
git clone https://github.com/SUFandom/onlyoffice_installer
```

then go inside the folder onlyoffice installer and run this:

```
chmod +x *.sh && sudo bash main.sh
```

and install now!

## Works on

- Debian (that has flatpak in repo)
- Ubuntu (18.10 or later)
- Arch Linux (may restart when installing Flatpak, the script will warn you that)