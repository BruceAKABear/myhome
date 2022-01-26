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

## 什么是MyHome

MyHome一套开源的智能家居系统，整个系统使用Java开发，使用的开发框架为springboot 2.6.3，使用的中间件包括但不限于MySQL、Redis、EMQX等。

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