# iotwrt
iot feeds

## libiot
- iotwrt基础库，提供JSON，网络通讯相关，基于cJSON和mongoose。编译后输出含ssl和不含ssl支持两个版本的动态库供调用。

## iot-mqtt
- rpc消息broker，为本地iot-rpcd，iot-httpd，iot-agent提供mqtt通讯服务。同时为远程iot-agent提供mqtts通讯服务。

## iot-rpcd
- rpcd服务端，南向调用iot-rpc实现的lua业务脚本，北向为本地iot-http和远程iot-agent提供服务。

## iot-rpc
- 实现业务逻辑的lua脚本，被iot-rpcd调用。

## iot-http
- http(s)服务器，将iot-rpcd服务以http api方式提供给外部调用。

## iot-agent
- 远程rpc调用agent，可供远端调用本地rpc接口。

## iot-controller
- 远程rpc调用controller，管理连接到本地的agent。

## broadcaster
- 广播发现服务端

## finder
- 广播发现客户端

## rulengd
- 规则引擎服务，用于简化事件及动作关联逻辑