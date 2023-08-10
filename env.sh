#!/usr/bin/env bash

# Set up tools and Environment
cd /tmp

# Install 7-zip
7zip='https://www.7-zip.org/a/7z2301-linux-x64.tar.xz'

wget $7zip
xz -d 7z2301-linux-x64.tar.xz && tar xvf 7z2301-linux-x64.tar
cp -r 7zzs /usr/local/bin/7z && chmod 0755 /usr/local/bin/7z

# Inatall payload-dumper-go
payload-dumper-go='https://github.com/ssut/payload-dumper-go/releases/download/1.2.2/payload-dumper-go_1.2.2_linux_amd64.tar.gz'

wget $payload-dumper-go
tar -xzf payload-dumper-go_1.2.2_linux_amd64.tar.gz
cp -r payload-dumper-go /usr/local/bin/payload-dumper-go && chmod 0775 /usr/local/bin/payload-dumper-go

# Test Tools
which 7z payload-dumper-go
7z --help
payload-dumper-go --help
