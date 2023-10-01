extends OptionButton

func _ready():
	if Global.animationState:select(0) 
	else:select(1) 

#当选项切换时
func _on_item_selected(index):
	var value:bool
	if get_item_text(index) == "True":
		value = true
	else:
		value = false
	Global.animationState = value
