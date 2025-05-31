#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Add autocore support for armvirt
# sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
#sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
#echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
#svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic

# 移除要替换的包
#rm -rf feeds/packages/net/v2ray-geodata

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 添加额外插件
#git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 添加主题
#git clone -b js --single-branch https://github.com/gngpp/luci-theme-design package/luci-theme-design
# git clone https://github.com/derisamedia/luci-theme-alpha.git package/luci-theme-alpha

# 添加测速插件
git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
# 添加 万能推送
# git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
# 添加关机插件
#git clone https://github.com/VPN-V2Ray/luci-app-poweroff.git package/luci-app-poweroff
# 添加passwall2
git clone https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
# 添加应用过滤
#git clone  https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
#加入turboacc
#curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh
#chmod -R 777 add_turboacc.sh
#bash add_turboacc.sh --no-sfe
# 添加分区扩容插件
git clone https://github.com/sirpdboy/luci-app-partexp.git package/luci-app-partexp


echo "
# 主题
#CONFIG_PACKAGE_luci-theme-design=y

CONFIG_PACKAGE_luci-theme-argon=y

#CONFIG_PACKAGE_luci-theme-material=y

#CONFIG_PACKAGE_luci-theme-openwrt-2020=y

#CONFIG_PACKAGE_luci-theme-alpha=y

# 测速插件
CONFIG_PACKAGE_luci-app-netspeedtest=y

# 万能推送
#CONFIG_PACKAGE_luci-app-pushbot=y

# TurboAcc
#CONFIG_PACKAGE_luci-app-turboacc=y

# 应用过滤
#CONFIG_PACKAGE_luci-app-oaf=y

# 添加passwall2
CONFIG_PACKAGE_luci-app-passwall2=y

# 添加分区扩容插件
CONFIG_PACKAGE_luci-app-partexp=y

" >> .config

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修改默认子网掩码
sed -i 's/255.255.255.0/255.255.252.0/g' package/base-files/files/bin/config_generate

# 修改默认主题
#sed -i 's/luci-theme-openwrt-2020/luci-theme-alpha/g' feeds/luci/collections/luci/Makefile

# Fix runc version error
# rm -rf ./feeds/packages/utils/runc/Makefile
# svn export https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages
# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------

