#!/bin/bash

git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 gcc
git clone https://github.com/VRanger/aosp-clang clang
make clean distclean
export ARCH=arm64
export KBUILD_BUILD_USER=Everest
export KBUILD_BUILD_HOST=HimalayaTeam
export USE_CCACHE=1
export CACHE_DIR=~/.ccache
tanggal=$(date +'%m%d-%H%M')

curl -F chat_id="-1001415832052" -F parse_mode="HTML" -F text="Building <b>Everest Kernel</b>
Compiler : <code>AOSP Clang</code>
Last Commit : <code>$(git log --oneline --decorate --color --pretty=%s --first-parent -1)</code>
Build Started on : <code>$(date)</code>
Build using : <code>SemaphoreCI</code>" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage

rm -rf output
mkdir output
START=$(date +"%s");
make O=output ARCH=arm64 santoni_treble_defconfig

PATH="/home/runner/android_kernel_xiaomi_santoni/clang/bin:/home/runner/android_kernel_xiaomi_santoni/gcc/bin:${PATH}" \
make -j$(nproc --all) O=output \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

if [ ! -f output/arch/arm64/boot/Image.gz-dtb ]; then

    sad[0]="CAADBQAD_QADcX38FEShXDvMS63qAg"

    sad[1]="CAADBQADCAEAAnF9_BQn_wgQXxXZYgI"

    sad[2]="CAADBQADlAADcX38FOe-kEXhrShYAg"

    randS=$[$RANDOM % ${#sad[@]}]

    sadS=${sad[$randS]}

    curl -F chat_id="-1001324692867" -F document=@"${tanggal}-Log.txt" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendDocument

    curl -F chat_id="-1001415832052" -F text="Build throw an error(s)" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage

    curl -F chat_id="-1001415832052" -F sticker="${sadS}" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker

    exit 1

else 

cp output/arch/arm64/boot/Image.gz-dtb AnyKernel2/zImage


cd AnyKernel2

rm -rf *.zip

zip -r9 EverestKernel-${tanggal}.zip * -x README.md EverestKernel-${tanggal}.zip

curl -F chat_id="-1001415832052" -F document=@"EverestKernel-${tanggal}.zip" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendDocument

END=$(date +"%s")

DIFF=$(($END - $START))

happy[0]="CAADBQAD4wADcX38FIeK7yk7KBaxAg"

happy[1]="CAADBQAD7wADcX38FBn4lWaZGvmtAg"

happy[2]="CAADBQADkwADcX38FOQ9JIMIFhnQAg"

randS=$[$RANDOM % ${#happy[@]}]

happyS=${happy[$randS]}


curl -F chat_id="-1001415832052" -F text="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds." https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage

curl -F chat_id="-1001415832052" -F sticker="${happyS}" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker


fi
