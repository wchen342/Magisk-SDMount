# Delay
while ! ( mount | grep '/storage/emulated' > /dev/null )
do
  log -t Magisk "Delaying..."
  sleep 10
done


# Create mount points
if [[ ! -d /storage/emulated/0/Mount_A ]]
then
  mkdir -p /storage/emulated/0/Mount_A
fi

if [[ ! -d /storage/emulated/0/Mount_B ]]
then
  mkdir -p /storage/emulated/0/Mount_B
fi

while ! ( mount | grep '/dev/block/vold/public:179,1' > /dev/null )
do
  log -t Magisk "Delaying Mount..."
  sleep 10
done

if [[ -e '/dev/block/vold/public:179,1' ]]
then
  log -t Magisk "Mounting..."
  /system/bin/mount -o nosuid,nodev,noexec,noatime '/dev/block/vold/public:179,1' /storage/emulated/0/Mount_A
  sleep 5
  mount -t sdcardfs -o nosuid,nodev,noexec,noatime /storage/emulated/0/Mount_A /storage/emulated/0/Mount_B
fi
