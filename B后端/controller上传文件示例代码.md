# controller上传文件示例代码

不跳转页面

```
       
    @RequestMapping("/addAppVersionsave")
    @ResponseBody
    public  Object addAppVersionsave(AppVersion appVersion , @RequestParam(value = "attach", required = false)MultipartFile attach
            ,HttpServletRequest  request){
        String apkLocPath = null;
        String path = request.getSession().getServletContext().getRealPath("statics/uploadfiles");

        String fileName="";
        if (!attach.isEmpty()) {
            fileName = attach.getOriginalFilename();//获得原文件名
            System.out.println("初始文件名字是"+fileName);
            String prefix = FilenameUtils.getExtension(fileName);//获得原文件名后缀
            int fileSize = 5000000;//设置文件大小限制
            if (attach.getSize() > fileSize) {
                return "{\"errorInfo\":\"上传大小不得超过5m\"}";

            } else if (prefix.equalsIgnoreCase("apk") ) {
                System.out.println("第二初始文件名字是"+fileName);
                File targetFile = new File(path, fileName);
                if (!targetFile.exists()) {
                    targetFile.mkdirs();//递归创建路径
                }
                //保存
                try {
                    attach.transferTo(targetFile);
                } catch (IOException e) {
                    e.printStackTrace();

                }

                //按下标设置路径名

                apkLocPath  = path + "/" + fileName;

            } else {
                return "{\"errorInfo\":\"apk格式不正确\"}";

            }

        }else {
            return "{\"errorInfo\":\"上传失败,您尚未选择文件或文件字节为0\"}";

        }
        //赋值
        System.out.println("文件名字是" + fileName);
        appVersion.setApkFileName(fileName);
        appVersion.setApkLocPath(apkLocPath);
        int result = 0;
        try {
            result = appVersionService.addVersion(appVersion);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result > 0) {

            return "{\"errorInfo\":\"上传成功\"}";
        }
        return "{\"errorInfo\":\"上传失败\"}";
    }
```

跳转页面：

```
@RequestMapping(value = "/useradd", method = RequestMethod.POST)
    public String saveAddUser(User user, HttpServletRequest request, HttpSession session, @RequestParam(value = "attachs", required = false)
            MultipartFile[] attachs) {
        String idPicPath = null;
        String workPicpath = null;
        String errorInfo = null;
        boolean flag = true;//设置上传成功或失败的标记
        String path = request.getSession().getServletContext().getRealPath("statics/uploadfiles");
        for (int i = 0; i < attachs.length; i++) {
            MultipartFile attach = attachs[i];
            if (!attach.isEmpty()) {
                if (i == 0) {
                    errorInfo = "uploadFileError";
                } else {
                    errorInfo = "uploadWpError";
                }
                String oldFileName = attach.getOriginalFilename();//获得原文件名
                String prefix = FilenameUtils.getExtension(oldFileName);//获得原文件名后缀
                int fileSize = 500000;//设置文件大小限制
                if (attach.getSize() > fileSize) {
                    request.setAttribute(errorInfo, "上传大小不得超过500kb");
                    flag = false;
                } else if (prefix.equalsIgnoreCase("jpg") ||
                        prefix.equalsIgnoreCase("png") ||
                        prefix.equalsIgnoreCase("jpeg") ||
                        prefix.equalsIgnoreCase("pneg")) {
                    String fileName = System.currentTimeMillis() + RandomUtils.nextInt(1000000) + "_Personal.jpg";
                    File targetFile = new File(path, fileName);
                    if (!targetFile.exists()) {
                        targetFile.mkdirs();//递归创建路径
                    }
                    //保存
                    try {
                        attach.transferTo(targetFile);
                    } catch (IOException e) {
                        e.printStackTrace();
                        request.setAttribute(errorInfo, "上传失败！");
                        flag = false;
                    }

                    //按下标设置路径名
                    if (i == 0) {
                        idPicPath = path + "/" + fileName;

                    } else if (i == 1) {
                        workPicpath = path + "/" + fileName;
                    }

                } else {
                    request.setAttribute(errorInfo, "上传图片格式不正确");
                    flag = false;
                }

            }
        }

        if (flag) {//如符合上传条件则给对象赋值
            user.setCreatedBy(((User) session.getAttribute("userSession")).getId());
            user.setCreationDate(new Date());
            /*赋值路径*/
            user.setIdPicPath(idPicPath);
            user.setWorkPicPath(workPicpath);
            try {
                if(userService.addUser(user)){
                    return "redirect:/user/userlist";

                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "useradd";

    }

```

```
ajax上传文件

var data= new FormData($( "body #versionaddform" )[0]);
            alert(data);
            $.ajax({
                type:"POST",
                url:rootpath+"/appVersion/addAppVersionsave.json",
                data:data,
                dataType:"json",
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success:function (data) {
                    if(data.errorInfo=="上传成功"){
                        istrue=true;
                    }
                    alert(data.errorInfo);
                }

            });
```
