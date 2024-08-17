# activiti入门

**总结activiti中的几个对象**

**几个和流程相关的对象**

Deployment：部署对象，和部署表(act_re_deployment)对应

ProcessDefinition：流程定义对象，和流程定义表(act_re_procdef)对应

ProcessInstance：流程实例对象，和流程实例表(act_ru_execution)对应

Task：任务对象，和任务表(act_ru_task)对应

**几个Service对象（用来操作）**

RepositoryService：操作部署、流程定义等静态资源信息

RuntimeService：操作流程实例，启动流程实例、查询流程实例、删除流程实例等动态信息

TaskService：操作任务，查询任务、办理任务等和任务相关的信息

HistoryService：操作历史信息的，查询历史信息

IdentityService：操作用户和组

FormService（操作表单（动态表单 普通表单和外置表单？））

**几个Query对象（用来查询）**

DeploymentQuery：对应查询部署表(act_re_deployment)

ProcessDefinitionQuery：对应查询流程定义表(act_re_procdef)

ProcessInstanceQuery：对应查询流程实例表(act_ru_execution)

TaskQuery：对应查询任务表(act_ru_task)

**##activiti****涉及到的表：**

_`act_ge_bytearray`_ #文件存放表

_`act_re_deployment`_#流程部署表

_`act_re_procdef`_ #流程表（类似于镜像的概念）

_`act_ru_execution`_ 正在执行的流程实例表

1、说明

ru:runtime

代表

如果当期正在执行的流程实例结束以后，该行在这张表中就被删除掉了，所以该表也是一个临时表

2、字段

proc_inst_id_:piid 流程实例ID，如果不存在并发的情况下，piid和executionID是一样的

act_id:当前正在执行的流程实例(如果不考虑并发的情况)的正在执行的activity有一个，所以act_id就是当前正在执行的流程实例的正在执行的

节点

_`act_hi_procinst`_ 流程实例历史表

1、说明

procinst:process instance 历史的流程实例

正在执行的流程实例也在这张表中

如果end_time_为null，说明正在执行，如果有值，说明该流程实例已经结束了

_`act_ru_task`_ 代表正在执行的任务表

1、说明

该表是一个临时表，如果当前任务被完成以后，任务在这张表中就被删除掉了

2、字段

id_: 主键 任务ID

execution_id_:执行ID

根据该ID查询出来的任务肯定是一个

proc_inst_id:piid

根据该id查询出来的任务

如果没有并发，则是一个

如果有并发，则是多个

name_:任务的名称

assignee_:任务的执行人

_`act_hi_taskinst`_ 流程历史记录表

1、说明

taskinst:task instance 历史任务

正在执行的任务也在这张表中

如果end_time_为null,说明该任务正在执行

如果end_time不为null,说明该任务已经执行完毕了

_`act_hi_actinst`_ 行为历史记录表

1、说明

act:activiti

hi:history

actinst:activity instance

流程图上出现的每一个元素都称为activity

流程图上正在执行的元素或者已经执行完成的元素称为activity instance

2、字段

proc_def_id:pdid

proc_inst_id:流程实例ID

execution_id_:执行ID

act_id_:activity

act_name

act_type
