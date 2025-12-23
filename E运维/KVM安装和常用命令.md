一、执行命令
sudo virt-install \
    --name=my_vm \          # 虚拟机名称，可自定义
    --ram=2048 \            # 分配内存大小（MB）
    --vcpus=2 \             # 分配虚拟CPU核心数
    --disk path=/var/lib/libvirt/images/my_vm.qcow2,size=20 \ # 系统磁盘路径和大小(GB)
    --os-type=linux \       # 操作系统类型
    --os-variant=centos7.0 \ # 操作系统变体（可选，用于优化配置）
    --network  --network bridge=br0,model=virtio  \ # 网络连接，默认使用NAT
    --graphics vnc,listen=0.0.0.0 \ # 使用VNC图形界面，并允许远程连接
    --cdrom /path/to/your/operating-system.iso \ # 替换为你的ISO镜像实际路径
    --noautoconsole         # 不自动弹出控制台
	
	
	
	
二、看VNC端口号
在终端输入以下命令，查看你的虚拟机 dss 的VNC显示端口：


 virsh vncdisplay dss



通常它会返回一个类似 :0 或 :1 的值。:0 对应端口 5900，:1 对应 5901，以此类推。





附：服务器上若想启动vnc，则：

sudo yum install tigervnc-server -y

vncserver :1   （开放5901端口， 0就是5900端口）







三、打开tigerVNC软件（vncviewer） 连接 ip:5900 即可。

四、直接连管理软件（mobaxterm）

export DISPLAY=192.168.18.81:0.0
virt-manager





=========================================



virsh list                  查看正在运行的KVM 虚拟机的状态
virsh list --all            查看全部的虚拟机状态
virsh dominfo [vmname]      获取虚机的详情信息

virsh start [vmname]        虚拟机开启（启动）
virsh reboot [vmname]       虚拟机重启
virsh shutdown [vmname]     虚拟机关闭
virsh destroy [vmname]      虚拟机强制关机、
virsh suspend [vmname]      虚拟机暂停
virsh resume [vmname]       虚拟机恢复
virsh undefine [vmname]     只删除配置文件，磁盘文件未删除，相当于从虚拟机中移除
virsh autostart [vmname]    设置为随物理机启动而启动（开机启动）


virsh snapshot-list [vmname]                   获取快照列表
virsh snapshot-create-as [vmname] [snapname]   创建快照
virsh snapshot-delete [vmname] [snapname]      创建快照
virsh snapshot-revert [vmname] [snapname]      恢复快照
virsh snapshot-info [vmname] [snapname]        快照详情

virsh domiflist [vmname]                       网络信息
virsh domblklist [vmname]                      物理信息


virt-clone -o [vmname]  -n [vmname_new]  -f  /dir/file.qcow2   使用模板虚拟机克隆



============================================================

virt-clone -o  testca -n testvca  -f  /soft/vms/testvca.qcow2
 guestmount -d testvca -i /mnt/dev


vi /mnt/dev/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/dev

 virsh start testvca

virt-clone -o  testca -n testvkms  -f  /soft/vms/testvkms.qcow2
 guestmount -d testvkms -i /mnt/dev

vi /mnt/dev/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/dev

 virsh start testvkms


virt-clone -o  testca -n testvldap  -f  /soft/vms/testvldap.qcow2
 guestmount -d testvldap -i /mnt/dev

vi /mnt/dev/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/dev

 virsh start testvldap

 ===========================================================


cd /etc/libvirt/qemu
scp centos-2003.xml root@192.168.5.16:/etc/libvirt/qemu

cd /var/lib/libvirt/images
scp 
virsh define /etc/libvirt/qemu/registry2.xml
/var/lib/libvirt/images/test.qcow2

virt-install --virt-type kvm --name base --ram 6144 --vcpus=4 --import --disk path= /soft/vms/testca.qcow2,format=qcow2 --network bridge=br0,model=virtio --graphics vnc,listen=0.0.0.0 --noautoconsole --os-type=linux



 =======================运营ca-非屏蔽机房====================================
virt-install --virt-type kvm --name ra-s --ram 4096 --vcpus=2 --import --disk path=/soft/vms/test001.qcow2,format=qcow2 --network bridge=br0,model=virtio --graphics vnc,listen=0.0.0.0 --noautoconsole --os-type=linux
-- ra-主
virt-clone -o  base -n ra-m  -f  /soft/vms/ra-m.qcow2
 guestmount -d ra-m -i /mnt/cadev/ra-m
vi /mnt/cadev/ra-m/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ra-m

--ra-从
virt-clone -o  base -n ra-s  -f  /soft/vms/ra-s.qcow2
 guestmount -d ra-s -i /mnt/cadev/ra-s

 umount /mnt/cadev/ra-s

guestmount -d common-moudle -i /mnt/dev

 umount /mnt/dev


--ca213主
virt-clone -o  base -n ca213-m  -f  /soft/vms/ca213-m.qcow2
 guestmount -d  ca213-m  -i /mnt/cadev/ca213-m
vi /mnt/cadev/ca213-m/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ca213-m

--ca213备
virt-clone -o  base -n ca213-s  -f  /soft/vms/ca213-s.qcow2
 guestmount -d  ca213-s  -i /mnt/cadev/ca213-s 
vi /mnt/cadev/ca213-s/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ca213-s




--ocsp-主
virt-clone -o  base -n ocsp-m  -f  /soft/vms/ocsp-m.qcow2
 guestmount -d ocsp-m -i /mnt/cadev/ocsp-m
vi /mnt/cadev/ocsp-m/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ocsp-m

--ocsp-备
virt-clone -o  base -n ocsp-s  -f  /soft/vms/ocsp-s.qcow2
 guestmount -d ocsp-s -i /mnt/cadev/ocsp-s
vi /mnt/cadev/ocsp-s/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ocsp-s
vrish start ocsp-s 

--数据库-主
virt-clone -o  base -n mysql-m  -f  /soft/vms/mysql-m.qcow2
 guestmount -d mysql-m -i /mnt/cadev/mysql-m
vi /mnt/cadev/mysql-m/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/mysql-m
virsh start mysql-m



virt-clone -o  base -n dm-test-s  -f  /soft/vms/dm-test-s.qcow2
 guestmount -d dm-test-s -i /mnt/cadev/dm-test-s
vi /mnt/cadev/dm-test-s/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/dm-test-s
virsh start dm-test-s



--数据库-备
virt-clone -o  base -n mysql-s  -f  /soft/vms/mysql-s.qcow2
 guestmount -d mysql-s -i /mnt/cadev/mysql-s
vi /mnt/cadev/mysql-s/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/mysql-s
virsh start mysql-s

--ldap-从
virt-clone -o  base -n ldap-s  -f  /soft/vms/ldap-s.qcow2
 guestmount -d ldap-s -i /mnt/cadev/ldap-s
vi /mnt/cadev/ldap-s/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ldap-s
virsh start ldap-s

 =======================运营ca-非屏蔽机房====================================
--ca-主 51
virt-clone -o  base -n ca-m  -f  /soft/vms/ca-m.qcow2
 guestmount -d ca-m -i /mnt/cadev/ca-m
vi /mnt/cadev/ca-m/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ca-m
virsh start ca-m

--ca-从 52
virt-clone -o  base -n ca-s  -f  /soft/vms/ca-s.qcow2
 guestmount -d ca-s -i /mnt/cadev/ca-s
vi /mnt/cadev/ca-s/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ca-s
virsh start ca-s

--数据库-主  54
virt-clone -o  base -n mysql-m  -f  /soft/vms/mysql-m.qcow2
 guestmount -d mysql-m -i /mnt/cadev/mysql-m
vi /mnt/cadev/mysql-m/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/mysql-m
virsh start mysql-m

--数据库-备  55
virt-clone -o  base -n mysql-s  -f  /soft/vms/mysql-s.qcow2
 guestmount -d mysql-s -i /mnt/cadev/mysql-s
vi /mnt/cadev/mysql-s/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/mysql-s
virsh start mysql-s

--ldap-主  53
virt-clone -o  base -n ldap-m  -f  /soft/vms/ldap-m.qcow2
 guestmount -d ldap-m -i /mnt/cadev/ldap-m
vi /mnt/cadev/ldap-m/etc/sysconfig/network-scripts/ifcfg-eth0
 umount /mnt/cadev/ldap-m
virsh start ldap-m

 =======================运营ca-屏蔽机房KMC====================================
--kms主 61
virt-clone -o  testca -n kms-m  -f  /soft/vms/kms-m.qcow2

--kms备 62
virt-clone -o  testca -n kms-s  -f  /soft/vms/kms-s.qcow2

--数据库-主 63
virt-clone -o  testca -n mysql-m  -f  /soft/vms/mysql-m.qcow2

--数据库-备 64
virt-clone -o  testca -n mysql-s  -f  /soft/vms/mysql-s.qcow2

 =======================运营ca-屏蔽机房ca====================================
virt-clone -o  testca -n testccm01  -f  /soft/vms/testccm01.qcow2


 =======================运营ca-非屏蔽机房====================================

 =======================运营ca-非屏蔽机房====================================