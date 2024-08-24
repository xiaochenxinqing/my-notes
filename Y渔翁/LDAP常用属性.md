# LDAP常用属性

一、LDAP使用场景

LDAP(Lightweight Directory Access Protocol)，轻量目录访问协议，LDAP目录以树状结构来存储数据。企业中使用LDAP主要是用来集中管理企业的组织结构及人员账号信息。

LDAP是一种通讯协议，AD（Active Directory）是微软对LDAP协议的一套实现，可以将AD理解为是个数据库，只是该数据库是以树状结构存储数据。

二、条件示例

条件内容 说明

manager=* 包含一个或多个 manager 属性值的条目

cn=Ray Kultgen 包含通用名 Ray Kultgen 的条目

(!(cn=Ray Kultgen)) 所有不包含通用名 Ray Kultgen 的条目

description=X.500 所有条目的说明属性中都包含子字符串X.500

(&(ou=Marketing)(!(description=X.500))) 所有组织单元为 Marketing 且说明字段中不包含子字符串 X.500 的条目

(&(ou=Marketing)((manager=cn=JulieFulmer,ou=Marketing,dc=siroe,dc=com)(manager=cn=CindyZwaska,ou=Marketing,dc=siroe,dc=com))) 所有组织单元为 Marketing 且manager 为 Julie Fulmer 或 CindyZwaska 的条目

(!(objectClass=person)) 返回所有不代表人员的条目

三、常用属性

属性名称 全称 说明

dn distinguished name 唯一标识名，类似于绝对路径，每个对象都有唯一标识名。例：uid=tester,ou=People,dc=example,dc=com

rdn relative distinguished name 相对标识名，类似于相对路径。例：uid=tester

uid user id 通常指用户登录名。例：uid=tester

sn sur name 通常指一个人的姓氏。例：sn: Wang

dc domain component 通常指定一个域名。例：DC=lenovo,DC=com

ou organization unit 通常指定一个组织单元的名称。例：OU=工业8.0部,DC=hspv,DC=com

cn common name 通常指一个对象的名称。如果是人，需要使用全名。例：CN=ldapadmin

c country 一个二位的国家代码。例：CN、US、HK、JP等。

四、用户属性

1、常规标签：

属性名称 说明

sn 姓

givenName 名

displayName 显示名称

initials 英文缩写

description 描述

physicalDeliveryOfficeName 办公室

telephoneNumber 电话号码

otherTelephone 电话号码：其它 otherTelephone 多个以英文分号分隔

mail 电子邮件

wwwHomePage 网页

url 网页，其它 url 多个以英文分号分隔

2、账号标签：

属性名称 说明

userPrincipalName 用户登录名，例：zs@abc.com

sAMAccountName 用户登录名（以前版本），例：190002

logonHours 登录时间，ldap的时间戳是从1601年1月1日0时起经过的1E-7秒（即100纳秒）的个数（时间是GMT的，中国的北京的时间需要加上8个小时）

accountExpires 帐户过期

3、电话标签：

属性名称 说明

homePhone 家庭电话(若是其它，在前面加other，例：otherhomePhone)

Pager 寻呼机

displayName 显示名称

mobile 移动电话，若多个以英文分号分隔

FacsimileTelephoneNumber 传真

ipPhone IP电话

Info 注释

4、单位标签：

属性名称 说明

Title 职务

Department 部门

Company 公司

5、地址标签：

属性名称 说明

C 国家/地区，例：中国CN，英国GB

St 省/自治区

L 市/县

streetAddress 街道

postOfficeBox 邮政信箱

postalCode 邮政编码

6、配置文件标签：

属性名称 说明

profilePath 配置文件路径

scriptPath 登录脚本

homeDirectory 主文件夹，本地路径

homeDrive 连接

homeDirectory 到
