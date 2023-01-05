### Variables
vmlinuz_file=$(ls -t vmlinuz-0-rescue* | head -1)
initramfs_file=$(ls -t initramfs-0-rescue* | head -1)
cd /boot
# Get the newest vmlinuz rescue file
vmlinuz_file=$(ls -t vmlinuz-0-rescue* | head -1)
# Get the newest initramfs rescue file
initramfs_file=$(ls -t initramfs-0-rescue* | head -1)
# Remove all vmlinuz rescue files except the newest one
for file in vmlinuz-0-rescue*; do
  if [ "${file}" != "${vmlinuz_file}" ]; then
    rm -f "${file}"
  fi
done
# Remove all initramfs rescue files except the newest one
for file in initramfs-rescue*; do
  if [ "${file}" != "${initramfs_file}" ]; then
    rm -f "${file}"
  fi
done
### Cleaning up old kernels
package-cleanup --oldkernels --count=2 -y
echo -e "${green}Old kernels and rescue images have been removed (except the last one)${black}\n"
### Régénération du GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
echo -e "${green}GRUB regenerated${black}\n"
echo -e "${green}You can reboot now${black}\n"
