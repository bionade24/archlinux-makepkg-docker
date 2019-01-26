FROM base/archlinux

RUN pacman -Syuq --needed --noconfirm git base-devel sudo namcap openssh  pyalpm asp

RUN    echo "Defaults        lecture = never" > /etc/sudoers.d/privacy \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel \
    && useradd -m -G wheel -s /bin/bash builder

USER builder
WORKDIR /home/builder
VOLUME ["/home/builder/.ssh"]

RUN    git clone https://aur.archlinux.org/pikaur.git \
    && cd yaourt \
    && makepkg -si --noconfirm \
    && cd .. \
    && rm -rf pikaur
