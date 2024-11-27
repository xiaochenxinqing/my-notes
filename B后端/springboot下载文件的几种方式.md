import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Files;

@RestController
public class FileController {
    
    public static final String fileNameStr="D:\\BaiduNetdiskDownload\\资料+文档\\RocketMQ分布式消息队列课件.pdf";
    
    /**
     * 小文件下载
     *
     * 都是先将文件读取到字节数组，然后再返回给客户端，如果文件太大，将文件内容读取到内存，可能会导致oom。
     *
     * 因此，了解就行了，不建议使用。
     *
     * 直接将文件一次性读取到内存中，然后通过response将文件内容输出到客户端，这种方式适合小文件，若文件比较大的时候，将文件一次性加载到内存中会导致OOM，这点需要注意
     * @param response
     * @throws IOException
     */
    @GetMapping("/download1")
    public void download1(HttpServletResponse response) throws IOException {
        // 指定要下载的文件
        //File file = ResourceUtils.getFile("classpath:2.zip");
        File file = ResourceUtils.getFile(fileNameStr);
        // 文件转成字节数组
        byte[] fileBytes = Files.readAllBytes(file.toPath());
        //文件名编码，防止中文乱码
        String filename = URLEncoder.encode(file.getName(), "UTF-8");
        // 设置响应头信息
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        // 内容类型为通用类型，表示二进制数据流
        response.setContentType("application/octet-stream");
        //输出文件内容
        try (OutputStream os = response.getOutputStream()) {
            os.write(fileBytes);
        }
    }
    
    /**
     * 小文件下载
     *
     * 方法需要返回`ResponseEntity`类型的对象，这个类是SpringBoot中自带的，是对http响应结果的一种封装，可以用来构建http响应结果：包含状态码、头、响应体等信息。
     *
     * 都是先将文件读取到字节数组，然后再返回给客户端，如果文件太大，将文件内容读取到内存，可能会导致oom。
     *
     * 因此，了解就行了，不建议使用。
     *
     * @return
     * @throws IOException
     */
    @GetMapping("/download2")
    public ResponseEntity<byte[]> download2() throws IOException {
        // 指定要下载的文件
        //File file = ResourceUtils.getFile("classpath:2.zip");
        File file = ResourceUtils.getFile(fileNameStr);
        // 文件转成字节数组
        byte[] fileBytes = Files.readAllBytes(file.toPath());
        //文件名编码，防止中文乱码
        String filename = URLEncoder.encode(file.getName(), "UTF-8");
        //构建响应实体：ResponseEntity，ResponseEntity中包含了http请求的响应信息，比如状态码、头、body
        ResponseEntity<byte[]> responseEntity = ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"").header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE).body(fileBytes);
        return responseEntity;
    }
    
    /**
     * 通用方案（适合任何大小文件），建议采用
     *
     * 边读取+边输出
     * @param response
     * @throws IOException
     */
    @GetMapping("/download3")
    public void download3(HttpServletResponse response) throws IOException {
        // 指定要下载的文件
        //File file = ResourceUtils.getFile("classpath:2.zip");
        File file = ResourceUtils.getFile(fileNameStr);
        //文件名编码，防止中文乱码
        String filename = URLEncoder.encode(file.getName(), "UTF-8");
        // 设置响应头信息
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        // 内容类型为通用类型，表示二进制数据流
        response.setContentType("application/octet-stream");
        // 循环，边读取边输出，可避免大文件时OOM
        try (InputStream inputStream = new FileInputStream(file); OutputStream os = response.getOutputStream()) {
            byte[] bytes = new byte[1024];
            int readLength;
            while ((readLength = inputStream.read(bytes)) != -1) {
                os.write(bytes, 0, readLength);
            }
        }
    }
     
    @GetMapping("/download4")
    public ResponseEntity<Resource> download4() throws IOException {
        /**
         * 通过 ResponseEntity 下载文件，body 为 org.springframework.core.io.Resource 类型
         * Resource是spring中的一个资源接口，是对资源的一种抽象，常见的几个实现类
         * ClassPathResource：classpath下面的文件资源
         * FileSystemResource：文件系统资源
         * InputStreamResource：流资源
         * ByteArrayResource：字节数组资源
         */
       // Resource resource = new ClassPathResource("2.zip");
        Resource resource = new FileSystemResource(fileNameStr);
        //文件名编码，防止中文乱码
        String filename = URLEncoder.encode(resource.getFilename(), "UTF-8");
        //构建响应实体：ResponseEntity，ResponseEntity中包含了http请求的响应信息，比如状态码、头、body
        ResponseEntity<Resource> responseEntity = ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"").header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE).body(resource);
        return responseEntity;
    }

}**总结：推荐用 download3的方式，download1和download2不太推荐**