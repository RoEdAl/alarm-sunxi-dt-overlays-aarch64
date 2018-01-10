#
# Device Tree overlays for sunxi devices
#

pkgbase='sunxi-dt-overlays'
pkgname=(
	'sunxi-dt-overlays-toolkit'
	'sun50i-h5-dt-overlays'
	'sun50i-h5-dto-analog-codec'
	'sun50i-h5-dto-cir'
	'sun50i-h5-dto-usbhost0'
	'sun50i-h5-dto-usbhost1'
	'sun50i-h5-dto-usbhost2'
	'sun50i-h5-dto-usbhost3'
)
pkgdesc='Device Tree overlays for sunxi devices'
pkgver=r54.4dfd904
pkgrel=1
arch=('aarch64')
_linux_kernel_pkg='linux-aarch64-rc'
url='http://github.com/armbian/sunxi-DT-overlays'
license=('GPL2')
makedepends=('git' 'dtc' 'uboot-tools')
options=('!strip')

source=('sunxi-dto::git+https://github.com/armbian/sunxi-DT-overlays.git'
	'upd-sunxi-dt-overlays.sh'
	'overlays.txt'
)
md5sums=('SKIP'
         'd4b39becf44d92e8578f82eddf5e7f37'
         '4d77cc0476d2f522e70f74573caeda31')

pkgver() {
  cd "${srcdir}/sunxi-dto"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
  cd "${srcdir}/sunxi-dto"

  for DTS in sun50i-h5/*.dts; do
     msg2 "DTS: ${DTS}"
     dtc -@ --warning no-unit_address_vs_reg --warning no-gpios_property -I dts -O dtb -o "${DTS/%.dts/.dtbo}" $DTS
  done

  mkimage -A arm64 -O linux -T script -C none -n "Allwinner H5 fixup" -d sun50i-h5/sun50i-h5-fixup.scr-cmd sun50i-h5/sun50i-h5-fixup.scr
}

package_sunxi-dt-overlays-toolkit() {
  pkgdesc='Device Tree overlays toolkit for Sunxi SoCs'

  install -Dm755 "${srcdir}/upd-sunxi-dt-overlays.sh" "${pkgdir}/usr/share/sunxi-dt-overlays/upd-sunxi-dt-overlays.sh"
}

# hook template
create_ovl_hook() {
  local OVL_PREFIX=$1
  local SOC_NAME=$2
  local BASE_DIR=$3

  (cat <<EOF
[Trigger]
Type = File
Operation = Install
Operation = Remove
Target = boot/dtbs/allwinner/overlay/${OVL_PREFIX}-*.dtbo
Target = etc/conf.d/${OVL_PREFIX}

[Action]
Description = Updating ${SOC_NAME} overlays
Depends = ${OVL_PREFIX}-dt-overlays
When = PostTransaction
Exec = /usr/bin/upd-${OVL_PREFIX}-dt-overlays
EOF
  ) >> "${BASE_DIR}/usr/share/libalpm/hooks/98-upd-${OVL_PREFIX}-dt-overlays.hook"
}

package_sun50i-h5-dt-overlays() {
  pkgdesc='Device Tree overlays for Allwinner H5 SoC'
  depends=($_linux_kernel_pkg 'sunxi-dt-overlays-toolkit')
  groups=('sun50i-h5-dto')
  backup=('boot/overlays.txt')
  provides=('sunxi-dt-overlays')
  conflicts=('sunxi-dt-overlays')
  
  install -dm755 ${pkgdir}/usr/bin
  ln -s /usr/share/sunxi-dt-overlays/upd-sunxi-dt-overlays.sh ${pkgdir}/usr/bin/upd-sun50i-h5-dt-overlays

  install -dm755 "${pkgdir}/usr/share/libalpm/hooks"
  create_ovl_hook 'sun50i-h5' 'Allwinner H5' "${pkgdir}"
  install -Dm644 "${srcdir}/overlays.txt" "${pkgdir}/boot/overlays.txt"

  cd "${srcdir}/sunxi-dto"
  install -Dm644 'sun50i-h5/sun50i-h5-fixup.scr' "${pkgdir}/boot/dtbs/allwinner/overlay/sun50i-h5-fixup.scr"
}

package_sun50i-h5-dto-analog-codec() {
  pkgdesc='Device Tree overlay for Allwinner H5 SoC - analog codec driver'
  groups=('sun50i-h5-dto')
  depends=('sun50i-h5-dt-overlays')

  cd "${srcdir}/sunxi-dto"

  install -Dm644 'sun50i-h5/sun50i-h5-analog-codec.dtbo' "${pkgdir}/boot/dtbs/allwinner/overlay/sun50i-h5-analog-codec.dtbo"
}

package_sun50i-h5-dto-cir() {
  pkgdesc='Device Tree overlay for Allwinner H5 SoC - CIR receiver'
  groups=('sun50i-h5-dto')
  depends=('sun50i-h5-dt-overlays')

  cd "${srcdir}/sunxi-dto"

  install -Dm644 'sun50i-h5/sun50i-h5-cir.dtbo' "${pkgdir}/boot/dtbs/allwinner/overlay/sun50i-h5-cir.dtbo"
}

package_sun50i-h5-dto-usbhost0() {
  pkgdesc='Device Tree overlay for Allwinner H5 SoC - USB host controler 0'
  groups=('sun50i-h5-dto')
  depends=('sun50i-h5-dt-overlays')

  cd "${srcdir}/sunxi-dto"

  install -Dm644 'sun50i-h5/sun50i-h5-usbhost0.dtbo' "${pkgdir}/boot/dtbs/allwinner/overlay/sun50i-h5-usbhost0.dtbo"
}

package_sun50i-h5-dto-usbhost1() {
  pkgdesc='Device Tree overlay for Allwinner H5 SoC - USB host controler 1'
  groups=('sun50i-h5-dto')
  depends=('sun50i-h5-dt-overlays')

  cd "${srcdir}/sunxi-dto"

  install -Dm644 'sun50i-h5/sun50i-h5-usbhost1.dtbo' "${pkgdir}/boot/dtbs/allwinner/overlay/sun50i-h5-usbhost1.dtbo"
}

package_sun50i-h5-dto-usbhost2() {
  pkgdesc='Device Tree overlay for Allwinner H5 SoC - USB host controler 2'
  groups=('sun50i-h5-dto')
  depends=('sun50i-h5-dt-overlays')

  cd "${srcdir}/sunxi-dto"

  install -Dm644 'sun50i-h5/sun50i-h5-usbhost2.dtbo' "${pkgdir}/boot/dtbs/allwinner/overlay/sun50i-h5-usbhost2.dtbo"
}

package_sun50i-h5-dto-usbhost3() {
  pkgdesc='Device Tree overlay for Allwinner H5 SoC - USB host controler 3'
  groups=('sun50i-h5-dto')
  depends=('sun50i-h5-dt-overlays')

  cd "${srcdir}/sunxi-dto"

  install -Dm644 'sun50i-h5/sun50i-h5-usbhost3.dtbo' "${pkgdir}/boot/dtbs/allwinner/overlay/sun50i-h5-usbhost3.dtbo"
}
