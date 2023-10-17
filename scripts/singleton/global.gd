#公用属性
extends Node

#单例
#数据库单例
var database:databaseManager 
#场景单例
var scenes:scenesMananger
#文件单例
var io:ioManager
#时间单例
var time:timeManager
#工具单例
var tools:toolsManager

#UI界面单例
#右键菜单管理
var contentMenuManager:Control
#todoItem管理器
var todoItemArea:Control

#系统核心数据
#当前软件版本
var version:String
#当前软件类型
var app_version:String

#用户核心数据
#是否开启动画特效
var animationState:bool

#临时变量
#当前显示提示的列表
var nowShowTipList:Button
#当前显示节点的名称
var nowListName:String
#当前显示的列表
var nowList:Button
#当前选中的节点
var nowItem:Button
#当前显示的右键菜单
var nowContentMenu:Panel
#当前显示的日期组件
var nowShowDate:Panel
#当前编辑的文本编辑器
var nowLineEditor:LineEdit

