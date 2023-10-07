#全部路径
extends Node

#数据目录
var user_path      = "user://"       #用户数据根目录
var user_db_path   = "user://db/"    #用户数据库目录
var user_conf_path = "user://conf/"  #用户配置文件目录

#随软件携带配置文件
var res_conf_path  = "res://conf/core.json" #软件携带配置文件目录


#数据库
var db_script = "res://addons/godot-sqlite/godot-sqlite.gd"
var db_path   = "user://db/list.db"
