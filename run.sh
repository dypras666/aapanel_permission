#!/bin/bash

# Pastikan script dijalankan sebagai root
if [ "$(id -u)" != "0" ]; then
   echo "Script ini harus dijalankan sebagai root" 1>&2
   exit 1
fi

# Tentukan path ke direktori wwwroot
WWWROOT="/www/wwwroot"

# Fungsi untuk memperbaiki permission
fix_permissions() {
    local path=$1
    find "$path" -type d -exec chmod 755 {} \;
    find "$path" -type f -exec chmod 644 {} \;
    chown -R www:www "$path"
}

# Jalankan fungsi untuk setiap subdirektori di wwwroot
for dir in "$WWWROOT"/*; do
    if [ -d "$dir" ]; then
        echo "Memperbaiki permission untuk $dir"
        fix_permissions "$dir"
    fi
done

echo "Selesai memperbaiki permission di $WWWROOT"
