## 中国大陆城市json&港澳台、世界城市json

##### 上传于 2019-10-25

##### 项目说明
由于公司小程序中需要实现按照字母排序城市的列表，用到中国城市以及世界城市的json，但是手头有没有该数据json，所以就去爬取了飞猪旅游的城市json列表并做了一些去重处理。

##### 项目目录
|--china-city-list.json   //中国大陆城市json

|--world-city-list.json   //港澳台、世界城市json

##### 数据结构
```
<!-- china-city-list.json -->
{
  city_list:[
    {
      "k":"A",    //城市首字母缩写
      "n":[{
          "c":"abazangzuqiangzuzizhizhou",    //城市中文拼音
          "cityCode":513200,    //城市代码
          "n":"阿坝藏族羌族自治州",   //城市名称
          "p":"四川省"    //城市所在省
        }]
  ,
  classify_list:[]    //首字母缩写数组
}

<!-- world-city-list.json -->
{
  city_list:[
    {
      "k":"A",    //城市首字母缩写
      "n":[{
          "c":"aomen",    //城市中文拼音
          "cityCode":820100,    //城市代码
          "m":"Macau",    //城市英文全称
          "n":"澳门",   //城市名称
          "x":"China",    //国家英文
          "y":"中国",      //城市所在国家
//        "p":"台湾省"    //台湾省所属的城市会有该项
        }]
  ,
  classify_list:[]    //首字母缩写数组
}
```
