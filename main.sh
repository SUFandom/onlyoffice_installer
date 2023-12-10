#!/bin/bash 
## This script is just a protest to the OnlyOffice Community for having implementation on Debian/Ubuntu Onlyoffice DocumentServer Sucks
## That the error #318 from them is still here in 2023, and its getting closer to 2024 and why is the OnlyOffice Installs suck (Written Dec. 9 2023)

if [ $(pwd) == $(pwd | grep -a "onlyoffice_installer") ]; then
    echo "In DIR"
else
    echo "Please run this script inside onlyoffice_directory"
    exit 1
fi

if [ $EUID == 0 ]; then
    echo "Good"
    unset PASSKEY
else 
    echo "Not running on SUDO"
    #sleep 3
    PASSKEY=$(dialog --backtitle "Enter Password" \
                --title "Enter Password for SUDO prompts"\
                --passwordbox "Enter SUDO password before continuing this session\n\nSee Security.md or the script's source for more info on how this script uses SUDO password\n\nOr just run the script back as sudo bash main.sh" 0 0 \
                2>&1 >/dev/tty)
    grab=$?
    if [ -z $PASSKEY ]; then 
        export DIALOGRC="scheme/error.thm"
        dialog --backtitle "ERROR" --title "Blank Password" --msgbox "The password you entered is blank..." 0 0
        unset DIALOGRC
        exit 1
    else 
        case $grab in 
            0)
                clear 
                echo "WARNING: The Password will be sent to the sudo"
                echo "Make sure some packages running the machine are trusted and does not interfere with bash"
                echo "$PASSKEY" | sudo -S $0
                grab_1=$?
                    case $grab_1 in
                        1)
                            echo "$PASSKEY" | sudo -S bash main.sh
                            grab_2=$?
                            case $grab_2 in
                                1)
                                    export DIALOGRC="scheme/error.thm"
                                    dialog --backtitle "ERROR" --title "Blank Password" --msgbox "The password you entered is blank..." 0 0
                                    unset DIALOGRC
                                    unset PASSKEY
                                    exit 1
                                    ;;
                            esac
                            ;;
                    esac
                ;;
            1)
                exit
            ;;
        esac
    fi 
fi

A="OnlyOffice Unofficial Installer"
V="0.1"
F="development"
unset PASSKEY


function msg {
    echo "$1"
}

function datetime {
    MDY=$(date +%m-%d-%y)
    SEC=$(date +%T)
    msg "$MDY - $SEC<s>"
}

function mdt {
    msg "$(datetime) - $1"
}

function msgbox {
    dialog --backtitle "$A - $V - $F" --title "$1" --msgbox "$2" 0 0
}

function yesno {
    dialog --backtitle "$A - $V - $F" --title "$1" --yes-label "Confirm" --no-label "Back" --yesno "$2" 0 0
}

function menu {
    PAGE=$(dialog --backtitle "$A - $V - $F" \
            --title "Main Menu" \
            --menu "Welcome to OnlyOffice Installer where you can install OnlyOffice the better way\n\nSelect Any installation Methods\n\nService provider is flatpak as always, So if this machine doesn't have flatpak, the script can try installing it\n\nYou can also request for a distro to get support if not on the list..." 0 0 \
            "Install OOF to Debian" "Install via Debian" \
            "Install OOF to Ubuntu" "Install via Ubuntu" \
            "Install OOF to Arch Linux" "Install via Arch Linux" \
            2>&1 >/dev/tty)
    local erv=$?
    case $erv in 
        1)
            exit 
            ;;
    esac 
    case $PAGE in 
        "Install OOF to Debian")
            yesno "Install OOF to Debian" "Are you sure you want to install OnlyOffice to Debian?"
            local erv=$?
            case $erv in 
                1)
                    menu 
                    ;;
                0)
                    clear
                    mdt "Installing OnlyOffice via Debian Method"
                    mdt "Detecting if Flatpak is Present..."
                    if [ -e "/usr/bin/flatpak" ] && [ -e "/usr/share/flatpak" ] && [ -e "/usr/share/man/man1/flatpak.1.gz" ]; then 
                        mdt "Flatpak installed..."
                        mdt "Inserting Flathub Repo"
                        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
                        mdt "Done"
                        mdt "Installing OnlyOffice"
                        flatpak install flathub org.onlyoffice.desktopeditors -y
                        mdt "Checking..."
                        flatpak info org.onlyoffice.desktopeditors
                        local ftc=$? 
                        case $ftc in 
                            0)
                                mdt "Package installed"
                                msg ""
                                read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi
                                ;; 
                            1)
                                mdt "Software was not installed"
                                mdt "If you repeated this a lot of times, please report this to dev"
                                msg ""
                                read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi 
                                ;;
                        esac
                    else 
                        mdt "Flatpak isn't installed..."
                        mdt "Installing..."
                        sudo apt installing flatpak -y
                        if [ -e "/usr/bin/flatpak" ] && [ -e "/usr/share/flatpak" ] && [ -e "/usr/share/man/man1/flatpak.1.gz" ]; then 
                            mdt "Flatpak installed..."
                            mdt "Inserting Flathub Repo"
                            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
                            mdt "Done"
                            mdt "Installing OnlyOffice"
                            flatpak install flathub org.onlyoffice.desktopeditors -y
                            mdt "Checking..."
                            flatpak info org.onlyoffice.desktopeditors
                            local ftc=$? 
                            case $ftc in 
                                0)
                                    mdt "Package installed"
                                    msg ""
                                    read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                    if [[ -n $RPS ]]; then 
                                        menu 
                                    else 
                                        menu 
                                    fi
                                    ;; 
                                1)
                                    mdt "Software was not installed"
                                    mdt "If you repeated this a lot of times, please report this to dev"
                                    msg ""
                                    read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                    if [[ -n $RPS ]]; then 
                                        menu 
                                    else 
                                        menu 
                                    fi 
                                    ;;
                            esac
                        else 
                            mdt "Uhhhhhhh"
                            mdt "Cant find flatpak even when tried to install"
                            mdt "Check your previliges and your internet connection and try again..."
                            read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi
                        fi 
                    fi 
                ;;
            esac 
            ;;
        "Install OOF to Ubuntu")
            yesno "Install OOF to Ubuntu" "Are you sure you want to install OnlyOffice to Ubuntu?\nAssuming that your Ubuntu is 18.10"
            local erv=$?
            case $erv in 
                1)
                    menu 
                    ;;
                0)
                    clear
                    mdt "Installing OnlyOffice via Ubuntu Method"
                    mdt "Detecting if Flatpak is Present..."
                    if [ -e "/usr/bin/flatpak" ] && [ -e "/usr/share/flatpak" ] && [ -e "/usr/share/man/man1/flatpak.1.gz" ]; then 
                        mdt "Flatpak installed..."
                        mdt "Inserting Flathub Repo"
                        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
                        mdt "Done"
                        mdt "Installing OnlyOffice"
                        flatpak install flathub org.onlyoffice.desktopeditors -y
                        mdt "Checking..."
                        flatpak info org.onlyoffice.desktopeditors
                        local ftc=$? 
                        case $ftc in 
                            0)
                                mdt "Package installed"
                                msg ""
                                read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi
                                ;; 
                            1)
                                mdt "Software was not installed"
                                mdt "If you repeated this a lot of times, please report this to dev"
                                msg ""
                                read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi 
                                ;;
                        esac
                    else 
                        mdt "Flatpak isn't installed..."
                        mdt "Installing..."
                        sudo apt installing flatpak -y
                        if [ -e "/usr/bin/flatpak" ] && [ -e "/usr/share/flatpak" ] && [ -e "/usr/share/man/man1/flatpak.1.gz" ]; then 
                            mdt "Flatpak installed..."
                            mdt "Inserting Flathub Repo"
                            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
                            mdt "Done"
                            mdt "Installing OnlyOffice"
                            flatpak install flathub org.onlyoffice.desktopeditors -y
                            mdt "Checking..."
                            flatpak info org.onlyoffice.desktopeditors
                            local ftc=$? 
                            case $ftc in 
                                0)
                                    mdt "Package installed"
                                    msg ""
                                    read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                    if [[ -n $RPS ]]; then 
                                        menu 
                                    else 
                                        menu 
                                    fi
                                    ;; 
                                1)
                                    mdt "Software was not installed"
                                    mdt "If you repeated this a lot of times, please report this to dev"
                                    msg ""
                                    read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                    if [[ -n $RPS ]]; then 
                                        menu 
                                    else 
                                        menu 
                                    fi 
                                    ;;
                            esac
                        else 
                            mdt "Uhhhhhhh"
                            mdt "Cant find flatpak even when tried to install"
                            mdt "Check your previliges and your internet connection and try again..."
                            read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi
                        fi 
                    fi 
                ;;
            esac 
            ;;
        "Install OOF on Arch Linux")
            yesno "Installing OOF on Arch" "Are you sure you want to install OnlyOffice on Arch?"
            local erv=$?
            case $erv in 
                1)
                    menu 
                    ;;
                0)
                    clear
                    mdt "Installing OnlyOffice via Arch Method"
                    mdt "Detecting if Flatpak is Present..."
                    if [ -e "/usr/bin/flatpak" ] && [ -e "/usr/share/flatpak" ] && [ -e "/usr/share/man/man1/flatpak.1.gz" ]; then 
                        mdt "Flatpak installed..."
                        mdt "Inserting Flathub Repo"
                        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
                        mdt "Done"
                        mdt "Installing OnlyOffice"
                        flatpak install flathub org.onlyoffice.desktopeditors -y
                        mdt "Checking..."
                        flatpak info org.onlyoffice.desktopeditors
                        local ftc=$? 
                        case $ftc in 
                            0)
                                mdt "Package installed"
                                msg ""
                                read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi
                                ;; 
                            1)
                                mdt "Software was not installed"
                                mdt "If you repeated this a lot of times, please report this to dev"
                                mdt "Check Internet connection"
                                msg ""
                                read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACK" RPS
                                if [[ -n $RPS ]]; then 
                                    menu 
                                else 
                                    menu 
                                fi 
                                ;;
                        esac
                    else 
                        mdt "Flatpak isn't installed..."
                        mdt "Installing..."
                        mdt "Calling Pacman to do -Syu and some installs"
                        sudo pacman -Syu
                        sudo pacman -Sy flatpak
                        if [ $? == 0 ]; then 
                            read -n 1 -t 100 -p "Flatpak is installed, but requires a restart, Press any key to restart system, then run this script to continue! (CTRL+C to cancel restart)" RPS
                            if [[ -n $RPS ]]; then 
                                mdt "REMEMBER TO RESTART THE SCRIPT TO CONTINUE INSTALLING ONLYOFFICE!"
                                sleep 10
                                mdt "REBOOTING NOW"
                                sleep 1
                                reboot -r
                            else 
                                mdt "REMEMBER TO RESTART THE SCRIPT TO CONTINUE INSTALLING ONLYOFFICE!"
                                sleep 10
                                mdt "REBOOTING NOW"
                                sleep 1
                                reboot -r
                            fi
                        else 
                            mdt "Pacman didn't installed flatpak"
                            mdt "Do it manually"
                            read -n 1 -t 100 -p "PRESS ANY KEY TO GO BACL" RPS
                            if [[ -n $RPS ]]; then 
                                menu
                            else 
                                menu
                            fi
                        fi
                    fi 
                ;;
            esac 
        esac
}


menu