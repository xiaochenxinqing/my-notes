# 利用Redis实现高并发计数器

# **利用Redis实现高并发计数器**

版权

业务需求中经常有需要用到计数器的场景：譬如一个手机号一天限制发送5条短信、一个接口一分钟限制多少请求、一个接口一天限制调用多少次等等。使用Redis的Incr自增命令可以轻松实现以上需求。以一个接口一天限制调用次数为例：

_/**_

_* 是否拒绝服务_

_*_ _@return_

_*/_

private boolean denialOfService(String userId){

long count=JedisUtil.setIncr(DateUtil.getDate()+"&"+userId+"&"+"queryCarViolation", 86400);

if(count<=10){

return false;

}

return true;

}

_/**_

_* 查询违�_�

_*_ _@param_ _plateNumber车牌_

_*_ _@param_ _vin 车架号_

_*_ _@param_ _engineNo发动机_

_*_ _@param_ _request_

_*_ _@param_ _response_

_*_ _@throws_ _Exception_

_*/_

@RequestMapping("/queryCarViolationList.json")

@AuthorizationApi

public void queryCarViolationList(@CurrentToken Token token,String plateNumber,String vin,

String engineNo,HttpServletRequest request,HttpServletResponse response) throws Exception {

    String userId=token.getUserId();

_//超过限制，拦截请求_

if(denialOfService(userId)){

apiData(request, response, ReqJson.error(CarError.ONLY_5_TIMES_A_DAY_CAN_BE_FOUND));

return;

}

_//没超过限制，业务逻辑……_

}

每次调用接口之前，先获得下计数器自增后的值，如果小于限制，放行，执行后面的代码。如果大于限制，则拦截掉。

JedisUtil工具类：

public class JedisUtil {

protected final static Logger logger = Logger.getLogger(JedisUtil.class);

private static JedisPool jedisPool;

@Autowired(required = true)

public void setJedisPool(JedisPool jedisPool) {

JedisUtil.jedisPool = jedisPool;

}

_/**_

_* 对某个键的值自增_

_*_ _@author_ _liboyi_

_*_ _@param_ _key 键_

_*_ _@param_ _cacheSeconds 超时时间，0为不超时_

_*_ _@return_

_*/_

public static long setIncr(String key, int cacheSeconds) {

long result = 0;

Jedis jedis = null;

try {

jedis = jedisPool.getResource();

result =jedis.incr(key);

if (cacheSeconds != 0) {

jedis.expire(key, cacheSeconds);

}

logger.debug("set "+ key + " = " + result);

} catch (Exception e) {

logger.warn("set "+ key + " = " + result);

} finally {

jedisPool.returnResource(jedis);

}

return result;

}

}
