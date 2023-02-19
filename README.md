<h1 align="center" style="font-size:50px;font-weight:bold">MyHome</h1>
<p align="center">Fully Open-Source Home Automation System Based On Java</p>
<p align="center">
    <a href="https://github.com/">
        <img src="https://img.shields.io/badge/license-GPL-blue" alt="GPL License" />
    </a>
    <a href="">
        <img src="https://img.shields.io/badge/version-v1.0.0-green" alt="v1.0">
    </a> 
    <a href="https://github.com/BruceAKABear">
        <img src="https://img.shields.io/badge/author-Brue-blueviolet" alt="Author">
    </a>
</p>

[中文文档](./docs/README_ZH.md)
## What is MyHome?

MyHome is a fully opensource Home-Automation control system,it backend system based on language Java ,frontend(pc or phone app) based on language Javascript.
in order to ensure the system safety,I make it running in local server,that means you need to install and running it in you local server which can run JVM(java virtual machine) and other environment.

MyHome core backend system is build with Java version 8, dashboard and Android application are build with Javascript(the reason why ios app not present is apple account is so expensive to me). The database I use mariadb for storing data, in order to connect devices,I use EMQX for device communication.
so, if you want to use MyHome,you need to install mariadb,EMQX,Java8

## For normal Users
in order, you can use this system,you need to let your MyHome administrator add you to the system,
then login to the system,then control everything you can control.
in myhome system we hava two different roles,one is householder and annother is normal users,the householder hava all permissions to control all devices,
and the normal users just hava the right to control the device except the permission one.
so when the householder add the device need to figure out the device need to be others control or not.

the householder login in to the backend control system to add device or debug device,make sure the device is running well for others,
the normal users use cell phone to control all the system functions

## For administrator

administrator is a basic role in system, you hava the right to control all functions and all devices.
the basic thing administrator need to do is add member and add devices to MyHome system.

### How to use MyHome?

## For Developers

### About the devices

I hava define devices in such different types:

1. 可控型
    1.1 布尔型
    1.2 比例型
    1.3 整数型
2. 不可控型（测量型设备）


## How to contact me?
my personal email is **dengyi@dengyi.pro** ,if you hava any better thoughts email me and let me know,maybe next 
version of MyHome will accept it as a core future.

## How to support me?

accutly all system develop are by myself. so,you support is very useful for me.

