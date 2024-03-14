mkdir -p ./workspace
cd ./workspace || exit 1
[ -f "$HOME/.netrc" ] && cp "$HOME/.netrc" ./
repo init -u https://code.rdkcentral.com/r/manifests -b kirkstone -m rdkb-extsrc.xml
repo sync -j`nproc` --no-clone-bundle
MACHINE=raspberrypi4-64-rdk-broadband source meta-cmf-raspberrypi/setup-environment
bitbake rdk-generic-broadband-image
