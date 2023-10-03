#数据库,负责数据的存储和书写
extends Node

#当前时间
var now_year   #当前年份
var now_month  #当前月份
var now_day    #当前天数
var now_week   #当前星期

#路径
var save_path  = "user://list/%s.json"#存储的路径
var expired_path   #过期任务路径
var today_path     #今天任务路径
var tomorrow_path  #明天任务路径
var week_path      #本周任务路径

#缓存
var expired_cache   #过期任务缓存
var today_cache     #今天任务缓存
var tomorrow_cache  #明天任务缓存
var week_cache      #本周任务缓存

#初始化
func _ready():
	#初始化当前时间
	time_check()
	update_path()
	update_cache()
	
#根据名称获取数据
func get_data_from_name(list:String):
	if list == "expired":
		return expired_cache
	elif list == "today":
		return today_cache
	elif list == "tomorrow":
		return tomorrow_cache
	elif list == "week":
		return week_cache

#时间校对
func time_check():
	var time   = Time.get_datetime_dict_from_system()
	now_year   = time.year
	now_month  = time.month
	now_day    = time.day
	now_week   = time.weekday

#更新数据路径
func update_path():
	#更新当天的路径
	today_path = save_path%(str(now_year)+str(now_month)+str(now_day))
	
	#更新明天的路径
	var days   = get_days_in_year_month(now_year,now_month)
	if now_day == days:
		tomorrow_path = save_path%(str(now_year)+str(now_month+1)+str(1))
	else:
		tomorrow_path = save_path%(str(now_year)+str(now_month)+str(now_day+1))
	
	#更新本周的路径
	var startDay = now_day - (now_week+1)
	if startDay + 7 > days: #当前周跨本月和下个月
		var supplementDay = startDay + 7 - days#下个月需要补充的天数
		var nowMonthDay   = startDay + 7 - supplementDay#这个月的天数
		for i in nowMonthDay:
			week_path.append(save_path%(str(now_year)+str(now_month)+str(now_day+i)))
		for i in (supplementDay):
			week_path.append(save_path%(str(now_year)+str(now_month+1)+str(i)))
	elif startDay < 0: #当前周跨本月和上个月
		var month = now_month
		var last_month_days = get_days_in_year_month(now_year,now_month-1)
		pass
	
#更新缓存
func update_cache():
	pass
	
#更新至指定缓存
func update_to_cache():
	pass

#读取
func read():
	pass
	
#存储
func save():
	pass

#获取天数胡
func get_days_in_year_month(year,month):
	match month:
		1 : return 31
		3 : return 31
		4 : return 30
		5 : return 31
		6 : return 30
		7 : return 31
		8 : return 31
		9 : return 30
		10: return 31
		11: return 30
		12: return 31
		2 : if (year%4==0) and (year%100 !=0) or (year%400)==0: return 29
	return 28
