## Expand (扩展)

#### Category
存放项目的分类

#### Const
存放项目一些常量，针对特定项目

#### Macros
存放一些项目中的常用的静态宏，针对所有项目

#### NetworkTool
项目中用到的网络请求封装

## Main（项目中的功能在些文件夹下,暂时只有两个）

#### Base
存放项目中可能用到的一些基类以及可能复用的文件

#### Login
登陆功能模块

## Resource（存放项目中用的资源）

#### Global
里面存放pch和.m等文件

#### Plist
存放plist文件

#### ImageAssets
存放项目中用到的图片

#### AppDelegate
存放AppDelegate

## SDKFile
存放例如友盟、百度等第三方SDK

## Vender
存放第三方库,现已经添加MJRefresh和JSONKit



重新建立工程的话，要将工程文件夹下所有文件删除，将示例文件夹下的目录拖进去
再把Podfile文件拖进去，
1 将Podfile中的名字改成工程的名字，要改四处
2 重新配置Info.plist路径
3 重新配置pch路径
4 添加arc
5 添加pods

可能需要在general -> identy 下面导入plist文件

