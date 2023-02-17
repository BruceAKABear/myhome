<h1 align="center" style="font-size:50px;font-weight:bold">MyHome</h1>
<p align="center">全开源的智能家居控制系统</p>
<p align="center">
    <a href="https://github.com/">
        <img src="https://img.shields.io/badge/license-GPL-blue" alt="GPL License" />
    </a>
    <a href="">
        <img src="https://img.shields.io/badge/version-v0.0.1-green" alt="v1.0">
    </a> 
    <a href="https://github.com/BruceAKABear">
        <img src="https://img.shields.io/badge/author-dengyi-blueviolet" alt="Author">
    </a>
</p>

[readme in english](../README.md)

## 什么是MyHome

MyHome是一套全开源的家居自动化控制

## 理念

1. 尽量减少对外界依赖
2. 人工控制具有最高优先级

存在一下几种情况只等思考
如：1. 场景设置当亮度小于100执行开灯

当检测到满足条件完成开灯后，人将灯再次关闭，传感器持续检测肯定会再次检测到亮度低于阈值，此时执行
相应的规则，将会再次执行开灯操作，这显然不太符合实际情况。因此场景在下发命令前需要检测最后一次
下发命令类型，如果是人下发，什么都不做。但是这样会出现一个情况是会导致场景永远失效，因为下发类型就
只有两种人或场景，而场景的前提是上一次控制不是人，只要人控制以后就不可能切换。因此觉得应该以一天
24小时作为检测时间段，超过24小时的还是可以执行。但是有没有一种情况是状态需要持续超过24小时的呢？


以上情况的第二种情况，设置了时间段亮度小于100执行开灯

判断条件参数数据结构

```json

[
  {
    "deviceId": "11223344",
    "deviceName": "开关1",
    "property": "open",
    "propertyName": "开关",
    "relation": ">=",
    "value": "10"
  }
]
```

执行结果传递数据结构：

```json
[
  {
    "deviceId": "11223344",
    "deviceName": "开关1",
    "property": "open",
    "propertyName": "开关",
    "value": "true",
    "valueName": "打开"
  }
]
```

## 设备

+ 产品

在MyHome系统中设备的顶级分类为产品，一个类型产品下可以有多个设备与之对应。如开关产品下包含所有的开关设备。

+ 通讯

    - 设备与服务器间通讯采用MQTT协议进行，选取MQTT而不是tcp或者http原因为MQTT可以控制通讯质量，同时通信质量必须设置为1.
    - 设备必须上定时报心跳数据包，数据包内容为当前设备状态，心跳上报时间间隔为60秒，系统65秒检测一次设备，如果第65秒内没检测到心跳上报，系统将认为设备离线。当设备离线后将不可对设备进行控制
  > 对设备的控制，仅限于可控设备。如果设备所属产品为平台不可控设备，无论如何都不能对设备进行控制。
    - 平台下发的控制命令为json格式数据，如：
      ```json 
        {
         "on": true 
        } 
        ```
    - 设备状态发生变更时也必须上报变更后的状态，以开关为例，当状态由关闭状态变更为开启状态时必须上报的数据为：

      ```json
      {
        "on": true
      }
      ```
    - 设备心跳上报数据内容为设备当前状态，以开关为例，心跳上报的数据为：

      ```json
      {
        "on": true
      }
      ```
+ MQTT消息队列

平台提供的队列一共有4中，每个设备必须自行实现这3个队列的逻辑。队列如下:

1. 心跳上报队列: /heartbeat ,通信质量:QOS=1
2. 平台下发控制命令队列: /control/产品ID/设备ID ,通信质量:QOS=1
3. OTA队列: /ota/产品ID ,通信质量QOS=1