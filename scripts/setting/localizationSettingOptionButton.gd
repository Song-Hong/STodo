extends OptionButton

func _ready():
	match TranslationServer.get_locale():
		"en"         : select(0) 
		"zh_Hans_CN" : select(1) 
		"zh_HK"      : select(2) 

#当选项切换时
func _on_item_selected(index):
	match get_item_text(index):
		"English" : TranslationServer.set_locale("en")
		"简体中文" : TranslationServer.set_locale("zh_Hans_CN")
		"繁体中文" : TranslationServer.set_locale("zh_HK")
		
