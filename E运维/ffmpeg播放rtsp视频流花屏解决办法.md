# ffmpeg播放rtsp视频流花屏解决办法

# ffmpeg播放rtsp视频流花屏解决办法

花屏有四个原因：

其一是发送数据包太大，超过了[ffmpeg](https://so.csdn.net/so/search?q=ffmpeg&spm=1001.2101.3001.7020)默认最大值。解决方法为下面的步骤 1。

其二是网络情况较差时，因网络状况出现的丢包而导致花屏。我这里是将有丢包的帧过滤掉，从而避免花屏现象。解决方法为下面的步骤2，3。

其三是因为解码出错。解决方法为下面的2，4，5，6，7，8，9。

其四是包乱序。通过查看rtp协议可知

要过滤掉丢包和解码出错的帧，首先需要找到丢包和解码出错的地方。通过ffmpeg打印的日志，再进行文本搜索，目前丢包的地方已明确找出，解码错误的地方找到以下几个地方，可能还有一些漏掉的，以后再慢慢补充。

1.修改udp.c    

        UDP_MAX_PKT_SIZE  大小x10   

        UDP_TX_BUF_SIZE

2设全局变量    在丢包或解码出错时将全局变量置为不同的值   最后在使用的地方根据全局变量的值来判断该帧是否完整   全局变量可在ffmpeg任意.h文件中设置  我是在avcodec.h中设置的

3.修改rtpdec.c文件包含 missed %d package的地方，这里出现丢包，需作标记

4.修改error_resilience.c文件 包含concealing %d DC, %d AC, %d MV errors in %c frame的地方。这里出现解包错误，需标记

5.修改h264_cavlc.c文件中包含 Invalid level prefix处 这里出错 需标记

  修改h264_cavlc.c文件中包含dquant out of range处，出错，需标记

  修改h264_cavlc.c文件中包含corrupted macroblock处，出错，需标记

  修改h264_cavlc.c文件中包含negative number of zero coeffs at处，出错，需标记

  修改h264_cavlc.c文件中包含mb_type %d in %c slice too large at %d %d处，出错，徐标记

  修改h264_cavlc.c文件中包含cbp too large处，出错，需标记  

6.修改error_resilience.c文件中包含Cannot use previous picture in error concealment处，出错，需标记

   修改error_resilience.c文件中包含Cannot use next picture in error concealment处，出错，需标记

7.修改h264.c文件中包含out of range intra chroma pred mode at处，出错，需标记

   修改h264.c文件中包含top block unavailable for requested intra mode at处，出错，需标记

   修改h264.c文件中包含left block unavailable for requested intra mode at处，出错，需标记

8.修改h264_slice.c文件中包含error while decoding MB处，出错，需标记

9.修改svq3.c文件中包含error while decoding MB处，出错，需标记

修改完成后，需重新编译ffmpeg源码。

可以在使用的时候将全局变量打印出来，会发现一旦有丢包或解码错误现象，全局变量就会有对应的值。这样就可以通过该全局变量来判断该帧是否完整了，从而过滤掉。

需要注意的是，每一帧处理后，都需要将全局变量重置。

在iOS上测试，即使在网络条件较差的情况下，基本上已经没有花屏现象。
