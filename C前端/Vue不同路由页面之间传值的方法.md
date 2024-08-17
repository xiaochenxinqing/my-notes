# Vue不同路由页面之间传值的方法

方法1:

路由:/aaa/bbb/:userId

this.queryParams.userId= this.$route.params && this.$route.params.userId

方法二

this.$router.push({ path: '/monitor/job-log/index', query: { jobId: jobId } })

const activityId = this.$route.query.activityId;

//参数获取，params和query区别，query参数在地址栏显示，params的参数不在地址栏显示
