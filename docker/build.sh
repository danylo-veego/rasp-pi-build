mkdir -p ./workspace
cd ./workspace || exit 1
[ -f "$HOME/.netrc" ] && cp "$HOME/.netrc" ./

repo init -u https://code.rdkcentral.com/r/manifests -b kirkstone -m rdkb-extsrc.xml || echo "repo init failed"

repo sync -j`nproc` --no-clone-bundle || echo "repo sync failed"

MACHINE=raspberrypi4-64-rdk-broadband source "meta-cmf-raspberrypi/setup-environment" || echo "source setup-environment failed"

bitbake rdk-generic-broadband-image || echo "bitbake rdk-generic-broadband-image failed"
