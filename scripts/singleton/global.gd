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

#菜单管理器
var contentMenuManager:Control
#todoItem管理器
var todoItemArea:Control

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

#设置
#是否开启动画特效
var animationState:bool
