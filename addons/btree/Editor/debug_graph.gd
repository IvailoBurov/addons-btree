@tool
extends GraphEdit

func gui_input(event):
	if  event is InputEventMouseButton and event.ctrl_pressed and event.shift_pressed and event.button_index == 4:
		zoom += 0.1
		accept_event()
	if  event is InputEventMouseButton and event.ctrl_pressed and event.shift_pressed and event.button_index == 5:
		zoom -= 0.1
		accept_event()
	return
