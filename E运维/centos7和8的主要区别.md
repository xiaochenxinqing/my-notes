# centos7和8的主要区别

# 网络管理

## centos7

云主机：centos7使用network管理网络，NetworkManager默认是关闭的

自己安装的centos7mini版：两个都是开启的

# centos版本 [root@yang ~]# cat /etc/redhat-release CentOS Linux release 7.9.2009 (Core)  # 内核版本 [root@yang ~]# uname -r3.10.0-1160.24.1.el7.x86_64  # 默认是启动的systemctl status network  # 默认是关闭的systemctl status NetworkManager

## centos8

centos8没有network，使用NetworkManager管理网络

修改ip地址等操作之后，使用systemctl restart NetworkManager重启网络服务

# centos版本 [root@VM-0-13-centos ~]# cat /etc/redhat-release CentOS Linux release 8.2.2004 (Core)  # 内核版本 [root@VM-0-13-centos ~]# uname -r4.18.0-193.28.1.el8_2.x86_64  # centos8 没有network [root@VM-0-13-centos ~]# systemctl status networkUnit network.service could not be found.

# yum和dnf

centos7只有yum，centos8有yum和dnf

Dandified 像花花公子的

|DNF（Dandified YUM）                                                                                                                                                                                                                                                 |YUM（Yellowdog Updater, Modified）               |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
|DNF 使用 libsolv 来解析依赖关系，由 SUSE 开发和维护                                                                                                                                                                                                                  |YUM 使用公开的 API 来解析依赖关系                |
|API 有完整的文档                                                                                                                                                                                                                                                     |API 没有完整的文档                               |
|由 C、C++、Python 编写的                                                                                                                                                                                                                                             |只用 Python 编写                                 |
|DNF 目前在 Fedora、RHEL 8、CentOS 8、OEL 8 和 Mageia 6/7 中使用                                                                                                                                                                                                      |YUM 目前在 RHEL 6/7、CentOS 6/7、OEL 6/7 中使用  |
|DNF 支持各种扩展                                                                                                                                                                                                                                                     |Yum 只支持基于 Python 的扩展                     |
|API 有良好的文档，因此很容易创建新的功能                                                                                                                                                                                                                             |因为 API 没有正确的文档化，所以创建新功能非常困难|
|DNF 在同步存储库的元数据时，使用的内存较少                                                                                                                                                                                                                           |在同步存储库的元数据时，YUM 使用了过多的内存     |
|DNF 使用满足性算法来解决依赖关系解析（它是用字典的方法来存储和检索包和依赖信息）                                                                                                                                                                                     |由于使用公开 API 的原因，Yum 依赖性解析变得迟钝  |
|从内存使用量和版本库元数据的依赖性解析来看，性能都不错                                                                                                                                                                                                               |总的来说，在很多因素的影响下，表现不佳           |
|DNF 更新：在 DNF 更新过程中，如果包中包含不相关的依赖，则不会更新                                                                                                                                                                                                    |YUM 将在没有验证的情况下更新软件包               |
|如果启用的存储库没有响应，DNF 将跳过它，并继续使用可用的存储库处理事务                                                                                                                                                                                               |如果有存储库不可用，YUM 会立即停止               |
|dnf update 和 dnf upgrade 是等价的                                                                                                                                                                                                                                   |在 Yum 中则不同                                  |
|安装包的依赖关系不更新                                                                                                                                                                                                                                               |Yum 为这种行为提供了一个选项                     |
|清理删除的包：当删除一个包时，DNF 会自动删除任何没有被用户明确安装的依赖包                                                                                                                                                                                           |Yum 不会这样做                                   |
|存储库缓存更新计划：默认情况下，系统启动后 10 分钟后，DNF 每小时会对配置的存储库检查一次更新。这个动作由系统定时器单元 dnf-makecache.timer 控制                                                                                                                      |Yum 也会这样做                                   |
|内核包不受 DNF 保护。不像 Yum，你可以删除所有的内核包，包括运行中的内核包                                                                                                                                                                                            |Yum 不允许你删除运行中的内核                     |
|libsolv：用于解包和读取资源库。hawkey: 为 libsolv 提供简化的 C 和 Python API 库。librepo: 提供 C 和 Python（类似 libcURL）API 的库，用于下载 Linux 存储库元数据和软件包。libcomps: 是 yum.comps 库的替代品。它是用纯 C 语言编写的库，有 Python 2 和 Python 3 的绑定。|Yum 不使用单独的库来执行这些功能                 |
|DNF 包含 29000 行代码                                                                                                                                                                                                                                                |Yum 包含 56000 行代码                            |
|DNF 由 Ales Kozumplik 开发                                                                                                                                                                                                                                           |YUM 由 Zdenek Pavlas、Jan Silhan 和团队成员开发  |

# 防火墙

centso7：firewalld底层使用iptables  centos8：nftables取代iptables  # **但是使用都是一样的(如: systemctl status firewalld**

# 时间同步

centso7支持NTP和chronyd  centos8只支持chronyd

# docker和podman

centos8 默认安装podman
