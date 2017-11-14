#!/bin/sh

# This is a temporary, simple build script until twrp is ready for anykernel

export ARCH=arm64
export SUBARCH=arm64
export CLANG_TRIPLE=aarch64-linux-gnu-
export CLANG_PATH=~/android/kernel/dtc4/bin
export CROSS_COMPILE=~/android/kernel/aarch64-linaro-linux-gnu/bin/aarch64-linux-gnu-
export REL="v1"
export TESTVER="$1"

make mrproper -j8
make electron_defconfig
make CC="ccache $CLANG_PATH/clang" -j8

rm ../img/device/google/wahoo-kernel/Image.lz4-dtb ../img/device/google/wahoo-kernel/*.ko;
cp arch/arm64/boot/Image.lz4-dtb ../img/device/google/wahoo-kernel/Image.lz4-dtb;
find . -name *.ko | xargs -I{} cp {} ../img/device/google/wahoo-kernel/;
cd ../img;
. build/envsetup.sh;
lunch aosp_taimen-user;
make installclean;
make bootimage -j8;
