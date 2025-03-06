# Centos7 ：磁盘挂载和磁盘扩容

https://zhuanlan.zhihu.com/p/621775504







示例：根据以下信息扩容



`[root@localhost ~]# fdisk -l`

`磁盘 /dev/sda：236.2 GB, 236223201280 字节，461373440 个扇区`
`Units = 扇区 of 1 * 512 = 512 bytes`
`扇区大小(逻辑/物理)：512 字节 / 512 字节`
`I/O 大小(最小/最佳)：512 字节 / 512 字节`
`磁盘标签类型：dos`
`磁盘标识符：0x000c85ed`

   `设备 Boot      Start         End      Blocks   Id  System`
`/dev/sda1   *        2048     2099199     1048576   83  Linux`
`/dev/sda2         2099200    75497471    36699136   8e  Linux LVM`

`磁盘 /dev/mapper/centos-root：34.4 GB, 34351349760 字节，67092480 个扇区`
`Units = 扇区 of 1 * 512 = 512 bytes`
`扇区大小(逻辑/物理)：512 字节 / 512 字节`
`I/O 大小(最小/最佳)：512 字节 / 512 字节`


`磁盘 /dev/mapper/centos-swap：3221 MB, 3221225472 字节，6291456 个扇区`
`Units = 扇区 of 1 * 512 = 512 bytes`
`扇区大小(逻辑/物理)：512 字节 / 512 字节`
`I/O 大小(最小/最佳)：512 字节 / 512 字节`

`[root@localhost ~]# df -h`
`文件系统                 容量  已用  可用 已用% 挂载点`
`/dev/mapper/centos-root   32G   12G   21G   36% /`
`devtmpfs                 3.9G     0  3.9G    0% /dev`
`tmpfs                    3.9G     0  3.9G    0% /dev/shm`
`tmpfs                    3.9G  9.6M  3.9G    1% /run`
`tmpfs                    3.9G     0  3.9G    0% /sys/fs/cgroup`
`/dev/sda1               1014M  166M  849M   17% /boot`
`tmpfs                    785M   12K  785M    1% /run/user/42`
`overlay                   32G   12G   21G   36% /var/lib/docker/overlay2/986f7de0dd02d6bfab8b18524f4a70f66d2c57a0ae8bdcd1bdb26974a7694c34/merged`
`tmpfs                    785M     0  785M    0% /run/user`





根据您的系统信息，您的根分区 `/dev/mapper/centos-root` 当前仅使用了 32G 空间，而磁盘 `/dev/sda` 总容量为 236GB，剩余约 200GB 未分配。您需要通过 LVM 进行扩容。以下是详细步骤：

------

**总结步骤应为：**

1. 使用parted调整sda2分区，覆盖所有未分配空间。
2. 重新扫描物理卷或重启系统，使内核识别新的分区大小。
3. 扩展物理卷（pvresize）。
4. 扩展逻辑卷（lvextend）。
5. 扩展文件系统（xfs_growfs或resize2fs）。



需要详细解释每个步骤的具体操作命令，并提醒用户谨慎操作，避免数据丢失。



------

### **1. 扩展 `/dev/sda2` 分区**

当前 `/dev/sda2` 分区仅占用 35GB，需先将其扩容以利用剩余空间。

#### **步骤**：

1. 安装 `parted` 工具（如未安装）：

   

   ```
   yum install -y parted
   ```

2. 启动 `parted`：

   

   ```
   parted /dev/sda
   ```

3. 在 `parted` 命令行操作：

   

   ```
   (parted) print               # 查看分区表
   (parted) resizepart 2        # 选择分区2（即sda2）
   Warning: Partition is in use. Do you want to continue? Yes
   End?  [35GB]? 100%           # 输入100%将分区扩展到磁盘最大容量
   (parted) quit
   ```

4. 重新扫描磁盘分区：

   

   ```
   partprobe /dev/sda
   ```

------

### **2. 扩展物理卷 (PV)**



```
pvresize /dev/sda2
```

#### **验证**：



```
pvdisplay
```

输出应显示 `/dev/sda2` 的容量增加到约 230GB。

------

### **3. 扩展逻辑卷 (LV)**



```
lvextend -l +100%FREE /dev/centos/root
```

#### **验证**：



```
lvdisplay
```

输出应显示 `/dev/centos/root` 的容量增加。

------

### **4. 扩展文件系统**

#### **（1）确认文件系统类型**：



```
df -Th /
```

如果输出显示 `xfs`（CentOS 7/8 默认），执行：



```
xfs_growfs /
```

#### **（2）最终验证**：



```
df -h /
```

输出应显示根分区的容量已扩展。

------

### **完整流程总结**



```
# 1. 扩展分区
parted /dev/sda resizepart 2 100%
partprobe /dev/sda

# 2. 扩展物理卷
pvresize /dev/sda2

# 3. 扩展逻辑卷
lvextend -l +100%FREE /dev/centos/root

# 4. 扩展文件系统
xfs_growfs /          # XFS 文件系统
# resize2fs /dev/centos/root  # ext4 文件系统
```

------

### **注意事项**

1. **备份数据**：操作前建议备份重要数据。
2. **分区工具**：使用 `parted` 而非 `fdisk`，因后者对 GPT 和大磁盘支持有限。
3. **无需重启**：`partprobe` 会通知内核分区表变更，无需重启。

------

