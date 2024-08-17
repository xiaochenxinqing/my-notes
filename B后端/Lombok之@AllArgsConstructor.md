# Lombok之@AllArgsConstructor

@Service

@AllArgsConstructor

public class ShiroService {

    private final PermissionService permissionService;

    private final ShiroFilterFactoryBean shiroFilterFactoryBean;

    private final FileUploadProperties fileUploadProperties;

}

作用: 等同于@Autowired  自动注入

@Service

public class ShiroService {

    @Autowired 

    private PermissionService permissionService;

    @Autowired 

    private ShiroFilterFactoryBean shiroFilterFactoryBean;

    @Autowired 

    private FileUploadProperties fileUploadProperties;

}

 
