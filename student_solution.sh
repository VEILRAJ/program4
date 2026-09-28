#!/bin/bash

# SELinux Access Denial Practical
# Student Name:
# Register Number:

echo "===== SELinux Status ====="
getenforce
sestatus

echo "===== Creating Web Directory ====="
sudo mkdir -p /var/www/html/selinux-test

echo "===== Creating HTML File ====="
echo "<html><body><h1>SELinux Practical Test</h1></body></html>" | sudo tee /var/www/html/selinux-test/index.html

echo "===== Setting Linux Permissions ====="
sudo chmod 644 /var/www/html/selinux-test/index.html
sudo chmod 755 /var/www/html/selinux-test

echo "===== Checking Initial Context ====="
ls -Zd /var/www/html/selinux-test
ls -Z /var/www/html/selinux-test/index.html

echo "===== Assigning Wrong SELinux Context ====="
sudo chcon -t user_home_t /var/www/html/selinux-test/index.html

echo "===== Checking Wrong Context ====="
ls -Z /var/www/html/selinux-test/index.html

echo "===== Checking AVC Denials ====="
sudo ausearch -m AVC -ts recent 2>/dev/null

echo "===== Correcting SELinux Context ====="
sudo restorecon -Rv /var/www/html/selinux-test

echo "===== Checking Correct Context ====="
ls -Z /var/www/html/selinux-test/index.html

echo "===== Practical Completed ====="

