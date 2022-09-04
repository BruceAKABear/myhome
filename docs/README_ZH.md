<h1 align="center" style="font-size:50px;font-weight:bold">MyHome-Community</h1>
<p align="center">基于Java的开源智能家居系统</p>
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

## 相关项目

[MyHome后台系统开源地址](https://github.com/BearLaboratory/myhome-community)

[MyHome后台系统管理页面地址](https://github.com/BearLaboratory/myhome-community)

[MyHome手机APP项目地址](https://github.com/BearLaboratory/myhome-community)

## 什么是MyHome

MyHome是一套开源的智能家居控制系统，整个系统使用Java语言开发。使用的开发框架为springboot
2.6.3，使用的中间件包括但不限于MySQL、Redis、EMQX等。

MyHome的基础概念是以家庭为中心进行私有化部署，私有化部署的目的是减少中心化部署带来的安全等缺陷。但是私有化部署也带来了其他不便捷的地方，如需要部署以家庭为单位的内网穿透
、需要手动修改硬件设备的配置等。但是在我看来，智能家居的安全性是最重要的，而MyHome只针对于小面积极客圈子使用，因此多方权衡下
采用此模式进行开发。

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