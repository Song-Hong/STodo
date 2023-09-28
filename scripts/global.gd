#公用属性
extends Node

#菜单管理器
var contentMenuManager:Control
#todoItem管理器
var todoItemArea:Control

#当前显示提示的列表
var nowShowTipList:Button
#当前显示的列表
var nowList
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
