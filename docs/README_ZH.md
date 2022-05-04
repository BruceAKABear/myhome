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

## 相关项目
[MyHome后台系统开源地址](https://github.com/BearLaboratory/myhome-community)

[MyHome后台系统管理页面地址](https://github.com/BearLaboratory/myhome-community)

[MyHome手机APP项目地址](https://github.com/BearLaboratory/myhome-community)


## 什么是MyHome

MyHome一套开源的智能家居系统，整个系统使用Java开发，使用的开发框架为springboot 2.6.3，使用的中间件包括但不限于MySQL、Redis、EMQX等。

MyHome的基础概念是以家庭为中心进行私有化部署，私有化部署的目的是减少中心化部署带来的安全等缺陷。但是也带来了其他不便捷的地方，如需要部署以家庭为单位的内网穿透
、需要手动修改硬件设备的配置等。但是在我看来，智能家居的安全性是最重要的，而MyHome只针对于小面积极客圈子使用，因此多方权衡下
采用此模式进行开发。

## 设备
+ 通讯
    
    - 设备与服务器间通讯采用MQTT协议进行，选取MQTT而不是tcp或者http原因为MQTT可以控制通讯质量，同时通信质量必须设置为1.
    - 设备必须上报心跳数据包，数据包内容为true，心跳上报时间间隔为30秒，系统35秒检测一次如果35秒内没检测到心跳上报，将会提示设备离线.
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