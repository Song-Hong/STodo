#时间管理
extends Node
class_name timeManager

#当前的日期
var year
var month
var day
var week

#缓存
var today
var tomorrow
var weeks

#初始化
func _init():
	set_singleton()  #设置单例
	var time = Time.get_datetime_dict_from_system()
	year     = time.year
	month    = time.month
	day      = time.day
	week     = time.weekday
	today    = get_now_day()
	tomorrow = get_tomorrow_day()
	weeks    = get_now_week()
	
	
#设置单例
func set_singleton():
	if Global.time == null:
		Global.time = self
	else:
		get_parent().remove_child(self)

#获取当天的日期字符串
func get_now_day_str():
	return str(year)+str(month)+str(day)

#对比
func compare(day1,day2):
	if day1[0] != day2[0]:
		return false
	if day1[1] != day2[1]:
		return false
	if day1[2] != day2[2]:
		return false
	return true

#对比
func compare_today(time:Array):
	if time[0] != year:
		return false
	if time[1] != month:
		return false
	if time[2] != day:
		return false
	return true

#获取当天的日期
func get_now_day():
	return [year,month,day]

#获取当前的实时时间
func get_now():
	var time = Time.get_datetime_dict_from_system()
	return [time.year,time.month,time.day,time.hour,time.minute,time.second]

#获取当前的实时时间字符串
func get_now_str():
	var time = Time.get_datetime_dict_from_system()
	return str(time.year)+str(time.month)+str(time.day)+str(time.hour)+str(time.minute)+str(time.second)

#获取明天的日期
func get_tomorrow_day():
	var now_year  = year
	var now_month = month
	var now_day   = day
	var days      = get_days_in_year_month(year,month)
	if now_day+1 > days:
		now_month += 1
		if now_month>12:
			now_month = 1
			now_year += 1
		now_day = 1
	else:
		now_day += 1
	return [now_year,now_month,now_day]

#获取明天的日期字符串
func get_tomorrow_day_str():
	var tomorrow = get_tomorrow_day()
	return str(tomorrow[0])+str(tomorrow[1])+str(tomorrow[2])

#获取这周的日期
func get_now_week():
	var weeks    = []
	var days     = Global.time.get_days_in_year_month(year,month)
	var now_day  = day
	var now_week = week
	if week == 0:
		now_week = 7
	var start_day = now_day-(now_week-1)
	var check_day = start_day+7
	if start_day<0:   #当前周横跨本月和上个月
		var now_month_week_days  = now_day
		var last_month_week_days = -start_day+1
		var now_month = month
		var now_year = year
		if now_month == 1:
			now_month = 12
			now_year -= 1;
		var last_month_days = Global.time.get_days_in_year_month(now_year,now_month)
		start_day = last_month_days-last_month_week_days
		for i in range(last_month_week_days):#上月需要补充的天数
			weeks.append([year,month,start_day+i])
		for i in range(now_month_week_days):#本月需要的天数
			weeks.append([year,month,i+1])
	elif check_day < days: #当前周就在本月
		for i in range(7):
			weeks.append([year,month,start_day+i])
	elif check_day>days: #当前周横跨本月和下个月
		var now_month_week_days  = days - start_day + 1
		var next_month_week_days = 7 - now_month_week_days
		for i in range(now_month_week_days):#这个月需要补充的天数
			weeks.append([year,month,start_day+i])
		for i in range(next_month_week_days):#下个月需要补充的天数
			weeks.append([year,month,i+1])
	return weeks

#获取这周的日期字符串
func get_now_week_str():
	var weeks   = get_now_week()
	var weekstr = []
	for data in weeks:
		weekstr.append(str(data[0])+str(data[1])+str(data[2]))
	return weekstr
	

#获取天数胡
func get_days_in_year_month(now_year,now_month):
	match now_month:
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
		2 : if (now_year%4==0) and (now_year%100 !=0) or (now_year%400)==0: return 29
	return 28

#获取当月第一天的星期数
func get_frist_day_week(now_year,now_month):
	var now_day = 1
	if now_month == 1 || now_month == 2 :
		now_month += 12
		now_year  -= 1
	return (now_day+2*now_month+3*(now_month+1)/5+ now_year +now_year/4-now_year/100+now_year/400+1)%7

#获取当前节点的唯一ID
func get_ID():
	var now_time  = get_now_str()
	var randomNum = str(randi() % 1000 + 1000)
	return "STODO" + now_time + str(randomNum)
