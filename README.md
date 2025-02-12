# iotwrt

iot feeds

## libiot

- iotwrt 基础库，提供 JSON，网络通讯相关，基于 cJSON 和 mongoose。编译后输出含 ssl 和不含 ssl 支持两个版本的动态库供调用。

## iot-mqtt

- rpc 消息 broker，为本地 iot-rpcd，iot-httpd，iot-agent 提供 mqtt 通讯服务。同时为远程 iot-agent 提供 mqtts 通讯服务。

## iot-rpcd

- rpcd 服务端，南向调用 iot-rpc 实现的 lua 业务脚本，北向为本地 iot-http 和远程 iot-agent 提供服务。

## iot-rpc

- 实现业务逻辑的 lua 脚本，被 iot-rpcd 调用。

## iot-http

- http(s)服务器，将 iot-rpcd 服务以 http api 方式提供给外部调用。

## iot-agent

- 远程 rpc 调用 agent，可供远端调用本地 rpc 接口。

## iot-controller

- 远程 rpc 调用 controller，管理连接到本地的 agent。


## iot-finder

- 服务发现server 和 client。

## rulengd

- 规则引擎服务，用于简化事件及动作关联逻辑

# tb-iot-sdk

## 系统模块划分

![](/iot-sdk.png)

## 调用流

![](/iot-sdk-flow.png)

## 调用时序

![](/iot-sdk-s.png)

## RPC 消息流

![](/iot-rpc-msg-flow.png)

---

## api

### request

- uri  
  `/api`
- 格式

```
{
    method : "method_name",
    param  : [] or {}
}
```

### response

- 格式

```
{
    code    : 0 or other,
    method  : "method_name",
    data    : [] or {}
}
```

- 说明：
  - 0 表示成功 其他失败
  - method [可选，用于回复回调路由]

---

## auth

### challenge

- 调用 login 方法登录前，必须先调用 challenge 方法获取预登陆 nonce
- 预登陆 nonce 用于防攻击，nonce 是后端生成的 32 位随机字符串
- nonce 默认 10 秒超时，因此该接口请求成功后应立即请求 login

- 请求

```json
POST http://<host>[:<port>]/api
{
	"method": "challenge",
	"param": {
		"username": "admin"
	}
}
```

- 响应

```json
{
  "data": {
    "username": "admin",
    "nonce": "<nonce>"
  },
  "method": "challenge",
  "code": 0
}
```

### login

- 前端密码计算方式：
  password=md5(md5(username:raw_password):nonce)
- 前端计算 password 所用的 nonce 在 challenge 阶段获取

- 成功返回 token，默认五分钟超时，用于鉴权，可用以下两种方法之一传递：

  - Cookie: access_token: token
  - Header: Authorization: Bearer token

- 请求

```json
POST http://<host>[:<port>]/api
{
	"method": "login",
	"param": {
		"username": "admin",
		"password": "{{password}}"
	}
}
```

- 响应

```
{
	"data": {
		"token": "<token>",
		"username": "admin"
	},
	"method": "login",
	"code": 0
}
```

### logout

- 退出登录调用此接口 以保证后端 token 刷新

```json
POST http://<host>[:<port>]/api
{
  "method": "logout"
}
```

### change_password

- 框架提供的修改密码接口

```json
POST http://<host>[:<port>]/api
{
    "method": "change_password",
    "param": {
        "username": "admin",
        "password": "<password>"
    }
}
```

---

## upload file

### 前端示例

- upload.html.sample

## 错误码

- -10000: 未登陆
- -10001: 参数错误
- -10002: 服务不可用
- -10003: 接口禁止调用
- -10004: 回复错误
- -10005: 频繁登录

## 使用 MQTT 协议直接访问业务接口方法

- 当前主要提供 HTTP API 接口，如需要通过 MQTT 协议直接调用业务逻辑，可通过如下方式：

  - 和本机 iot-rpcd 通信（调用本机 iot-rpc 实现的业务接口）

  ```
  1. publish 请求如：'{"method": "method_name", "param" : []  or {} }' 到主题 mg/{app_topic_prefix}/iot-rpcd

  2. subscribe 主题 mg/{app_topic_prefix} 用来接收回复，
  iot-rpcd会将回复publish到主题mg/{app_topic_prefix}

  3. 可以通过app_topic_prefix 传递请求id等业务信息，具体参考iot-http和iot-rpcd的主题设计实现

  4. 注：{app_topic_prefix}的不要和内置业务主题冲突。
  ```

  - 和远程 iot-rpcd 通信（调用远端 iot-rpc 实现的业务接口，如在 ac 上直接调用 ap 实现的业务接口）

  ```
  1. 被控端设备(如ap)的iot-agent使用-u {devid}参数 连接到控制端（如ac）

  2. 控制端publish 请求如：'{"method": "method_name", "param" : []  or {} }' 到主题 device/{devid}/rpc/request/{app_topic_prefix}/{reqid}

  3. 控制端subscribe 主题 device/+/rpc/response/{app_topic_prefix}/+ 用来接收回复，
  被控端iot-agent会将回复publish到主题 device/{devid}/rpc/response/{app_topic_prefix}/{reqid}

  ```

  - 和 iot-mqtt 通讯（目前支持获取 client 列表）

  ```
  1. publish请求如：'{"method": "method_name", "param" : []  or {} }' 到主题 mg/{app_topic_prefix}/$iot-mqtt

  2. subscribe 主题 mg/{app_topic_prefix} 用来接收回复。
  iot-mqtt会将回复publish到主题mg/{app_topic_prefix}

  ```

## 透传 rpc request

- 某些场景需要 iot-rpcd 将请求或指令直接透传给其他程序处理，可以在 request 中携带 proxy 字段，字段值为接收主题，有该字段时，iot-rpcd 直接将请求体 pub 到指定主题，不再调用 lua 业务逻辑处理，如：
  ```
  {
      "method": "method_name",
      "proxy": "proxy_topic_name",
      "param" : []  or {}
  }
  此请求将被iot-rpcd直接通过mqtt协议转发到proxy_topic_name，不再调用iot-rpc.lua处理。
  ```
- 订阅 proxy_topic_name 主题的应用将收到：

  ```
    {
        "method": "method_name",
        "proxy": "proxy_topic_name",
        "topic": "topic_name",
        "param" : []  or {}
    }

    应用实现的cgi将业务逻辑要回复给前端的结果publish到主题topic_name
  ```

## 使用 websocket 调用业务接口

- HTTP API 接口满足立即返回全部结果的场景，某些场景是一次调用，持续多次返回结果的情况，如排障功能调用 ping 命令，需要持续返回 ping 结果给前端，避免前端卡死等待和前端多次请求，可以使用 websocket 的方式，后台主动推送结果给前端。

### request

- uri  
   `/websocket` 本机调用  
   `/device/{devid}/websocket` 远程调用，当{devid}为特定设备的id时，和单设备通讯。当为$all时，和所有设备通讯，并可以通过filter字段之和部分设备通信。

```
{
    method : "method_name",
    param  : [] or {},
    filter : [ "devid1", "devid2", ... ] //可选
}
```

### response

- 格式

```
{
    code    : 0 or other,
    method  : "method_name",
    data    : [] or {}
}
```

### rpc 实现方式

- iot-rpc.lua 接收到参数如下【相对于原始请求参数自动增加了 topic 字段，用于发送回复结果】：

```
{
    method : "method_name",
    param  : [] or {},
    topic  : "topic_name"
}
```

- lua 实现的 cgi 将业务逻辑要回复给前端的结果 publish 到主题 topic_name.
- 注：可以在 requset 中增加自定义字段，关联前端业务请求会话，即将 requeset 和 response 进行业务逻辑关联。
