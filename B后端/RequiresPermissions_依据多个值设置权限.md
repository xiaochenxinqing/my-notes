# RequiresPermissions 依据多个值设置权限

：[RequiresPermissions 依据多个值设置权限](https://blog.csdn.net/zl_1987/article/details/51918957)

@RequiresPermissions(value = {"elevator:view", "onlineMonitoring:view"}, logical = Logical.OR)

Logical.OR是指value 中的权限任选其一

Logical.AND是指value 中的权限都要有，默认为and
