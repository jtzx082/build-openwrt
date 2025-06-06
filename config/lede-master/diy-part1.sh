#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
echo 'src-git netspeedtest https://github.com/sirpdboy/luci-app-netspeedtest' >>feeds.conf.default
echo 'src-git partexp https://github.com/sirpdboy/luci-app-partexp.git' >>feeds.conf.default
#echo 'src-git imluci https://github.com/immortalwrt/luci.git;openwrt-24.10' >>feeds.conf.default
echo 'src-git impackages https://github.com/immortalwrt/packages.git' >>feeds.conf.default
echo 'src-git imluci https://github.com/immortalwrt/luci.git' >>feeds.conf.default
# other
# rm -rf package/lean/{samba4,luci-app-samba4,luci-app-ttyd}

