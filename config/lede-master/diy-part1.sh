#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# 修复erofs编译依赖
sed -i 's/DEPENDS:= /DEPENDS:= +liblz4 +libuuid /' package/utils/erofs-utils/Makefile

# 若仍失败，回退到稳定版本
#echo "src-git erofs https://github.com/openwrt/openwrt.git" >> feeds.conf.default

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
echo 'src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main' >>feeds.conf.default
echo 'src-git partexp https://github.com/sirpdboy/luci-app-partexp.git;main' >>feeds.conf.default
echo 'src-git netspeedtest https://github.com/sirpdboy/luci-app-netspeedtest.git' >>feeds.conf.default
echo 'src-git netwizard https://github.com/sirpdboy/luci-app-netwizard.git' >>feeds.conf.default
echo 'src-git watchdog https://github.com/sirpdboy/luci-app-watchdog.git' >>feeds.conf.default
#echo 'src-git advancedplus https://github.com/sirpdboy/luci-app-advancedplus.git' >>feeds.conf.default
echo 'src-git taskplan https://github.com/sirpdboy/luci-app-taskplan.git' >>feeds.conf.default
echo 'src-git timecontrol https://github.com/sirpdboy/luci-app-timecontrol.git' >>feeds.conf.default
#echo 'src-git parentcontrol https://github.com/sirpdboy/luci-app-parentcontrol.git' >>feeds.conf.default
#echo 'src-git eqosplus https://github.com/sirpdboy/luci-app-eqosplus.git' >>feeds.conf.default
echo 'src-git poweroffdevice https://github.com/sirpdboy/luci-app-poweroffdevice.git' >>feeds.conf.default

# other
# rm -rf package/lean/{samba4,luci-app-samba4,luci-app-ttyd}

