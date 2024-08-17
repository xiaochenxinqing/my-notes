# java判断一个字符串是不是数字的方法

java判断一个字符串是不是数字的方法

1 //方法一：用JAVA自带的函数

```
2 public static boolean isNumeric(String str){
3    for (int i = str.length();--i>=0;){  
4        if (!Character.isDigit(str.charAt(i))){
5            return false;
6        }
7    }
8    return true;
9 }
```

/*方法二：推荐，速度最快

  * 判断是否为整数

  * @param str 传入的字符串

  * @return 是整数返回true,否则返回false

*/

```
  public static boolean isInteger(String str) {  
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");  
        return pattern.matcher(str).matches();  
  }
```

//方法三：

```
public static boolean isNumeric(String str){
    Pattern pattern = Pattern.compile("[0-9]*");
    return pattern.matcher(str).matches();   
}
```

//方法四：

```
public final static boolean isNumeric(String s) {
    if (s != null && !"".equals(s.trim()))
        return s.matches("^[0-9]*$");
    else
        return false;
}    
```

    

//方法五：用ascii码

```
public static boolean isNumeric(String str){
    for(int i=str.length();--i>=0;){
        int chr=str.charAt(i);
        if(chr<48 || chr>57)
            return false;
    }
   return true;
}   
```

  
