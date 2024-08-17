# ffmpeg_sources – 源代码下载后存放的地方，完成指引后这样可以被删掉。

ffmpeg_sources – 源代码下载后存放的地方，完成指引后这样可以被删掉。

ffmpeg_build – 一些辅助编译的文件或者库文件的存放目录，完成指引后这样可以被删掉。

bin – 最终的二进制文件(ffmpeg, ffprobe, x264, x265)安装的地方

**1、安装基础依赖**

yum install autoconf automake bzip2 bzip2-devel cmake freetype-devel gcc gcc-c++ git libtool make pkgconfig zlib-devel

**2、安装ffmpeg插件**

2.1. 创建安装目录

mkdir ~/ffmpeg_sources

2.2. 安装NASM

cd ~/ffmpeg_sources

curl -O -L https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.bz2

tar xjvf nasm-2.15.05.tar.bz2

cd nasm-2.15.05

./autogen.sh

./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"

make

make install

2.3. 安装YASM

cd ~/ffmpeg_sources

curl -O -L https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz

tar xzvf yasm-1.3.0.tar.gz

cd yasm-1.3.0

./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"

make

make install

2.4. 安装libx264（编译ffmpeg时配置–enable-gpl --enable-libx264）

cd ~/ffmpeg_sources

git clone --branch stable --depth 1 https://code.videolan.org/videolan/x264.git

cd x264

PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static

make

make install

2.5. 安装libx265（编译ffmpeg时配置–enable-gpl --enable-libx265)

cd ~/ffmpeg_sources

git clone --branch stable --depth 2 https://bitbucket.org/multicoreware/x265_git

cd ~/ffmpeg_sources/x265_git/build/linux

cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source

make

make install

2.6 安装libfdk_aac（编译ffmpeg时配置–enable-libfdk_aac (如果配了–enable-gpl，则同时需要配–enable-nonfree )

cd ~/ffmpeg_sources

git clone --depth 1 https://github.com/mstorsjo/fdk-aac

cd fdk-aac

autoreconf -fiv

./configure --prefix="$HOME/ffmpeg_build" --disable-shared

make

make install

2.7 安装libmp3lame（编译ffmpeg时配置 --enable-libmp3lame）

cd ~/ffmpeg_sources

curl -O -L https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz

tar xzvf lame-3.100.tar.gz

cd lame-3.100

./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm

make

make install

2.8 安装libopus（编译ffmpeg时配置–enable-libopus)

cd ~/ffmpeg_sources

curl -O -L https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz

tar xzvf opus-1.3.1.tar.gz

cd opus-1.3.1

./configure --prefix="$HOME/ffmpeg_build" --disable-shared

make

make install

2.9 安装libvpx（编译ffmpeg时配置–enable-libvpx)

cd ~/ffmpeg_sources

git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git

cd libvpx

./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm

make

make install

安装ffmpeg

cd ~/ffmpeg_sources

curl -O -L https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2

tar xjvf ffmpeg-snapshot.tar.bz2

cd ffmpeg

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \

  --prefix="$HOME/ffmpeg_build" \

  --pkg-config-flags="--static" \

  --extra-cflags="-I$HOME/ffmpeg_build/include" \

  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \

  --extra-libs=-lpthread \

  --extra-libs=-lm \

  --bindir="$HOME/bin" \

  --enable-gpl \

  --enable-libfdk_aac \

  --enable-libfreetype \

  --enable-libmp3lame \

  --enable-libopus \

  --enable-libvpx \

  --enable-libx264 \

  --enable-libx265 \

  --enable-nonfree

make

make install

hash -d ffmpeg

参考链接: https://trac.ffmpeg.org/wiki/CompilationGuide/Centos#RevertingChangesmadebythisGuide

————————————————

版权声明：本文为CSDN博主「jxhaha」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。

原文链接：https://blog.csdn.net/jxhaha/article/details/127428026
