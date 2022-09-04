<h1 align="center" style="font-size:50px;font-weight:bold">MyHome</h1>
<p align="center">Home Automation System Based On Java</p>
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

[中文文档](./docs/README_ZH.md)
## What is MyHome?

MyHome is a fully opensource Home-Automation control system,it based on language Java and Javascript.
in order to ensure the system safety,I make it running in local server,that means you need to install and running it in you local server which can run JVM(java virtual machine) and other environment.

MyHome core backend is build with Java version 8, dashboard and Android application are build with Javascript. The database I use mariadb for storing data, in order to connect devices,I use EMQX for device communication.
so, if you want to use MyHome,you need to install mariadb,EMQX,Java8

## For Users

in myhome system we hava two different roles,one is householder and annother is normal users,the householder hava all permissions to control all devices,
and the normal users just hava the right to control the device except the permission one.
so when the householder add the device need to figure out the device need to be others control or not.

the householder login in to the backend control system to add device or debug device,make sure the device is running well for others,
the normal users use cell phone to control all the system functions

## For householder


### How to use MyHome?

## For Developers

## How to contact me?
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