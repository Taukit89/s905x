#!/bin/bash
# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM luci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Modify default language(FROM zh_cn CHANGE TO en)
sed -i "s/zh_cn/en/g" feeds/luci/modules/luci-base/root/etc/uci-defaults/luci-base
sed -i "s/zh_cn/en/g" package/lean/default-settings/files/zzz-default-settings

# Modify default timezone(FROM Shanghai/CST-8 CHANGE TO Jakarta/WIB-7)
sed -i "s/CST-8/WIB-7/g" package/lean/default-settings/files/zzz-default-settings
sed -i "s/Shanghai/Jakarta/g" package/lean/default-settings/files/zzz-default-settings

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='Homemade'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.10.1）
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# Modify default Hostname (FROM OpenWRT CHANGE TO Taukit)
sed -i 's/OpenWrt/Taukit/g' package/base-files/files/bin/config_generate

# Modify default NTP Server
sed -i 's/ntp.aliyun.com/0.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
sed -i 's/time1.cloud.tencent.com/1.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
sed -i 's/time.ustc.edu.cn/2.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
sed -i 's/cn.pool.ntp.org/3.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/openwrt-openclash
pushd package/openwrt-openclash/tools/po2lmo && make && sudo make install 2>/dev/null && popd
#
# ------------------------------- Other ends -------------------------------

