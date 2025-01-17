@tool
extends GraphNode

const Runtime = preload("res://addons/btree/Runtime/runtime.gd")
var type = -1
var undo_redo:UndoRedo

func _ready():
	$slot0/Add.connect("pressed", Callable(self, "add_pressed"))
	$slot0/Del.connect("pressed", Callable(self, "del_pressed"))
	connect("delete_request", Callable(self, "close_request")) #ivo 4.2 ???
	return

func _enter_tree():
	title = name
	return

func as_sequence():
	type = Runtime.TNodeTypes.SEQUENCE
	name = "sequence"
	return

func as_selector():
	type = Runtime.TNodeTypes.SELECTOR
	name = "selector"
	return

func as_paralel():
	type = Runtime.TNodeTypes.PARALEL
	name = "paralel"
	return

func as_race():
	type = Runtime.TNodeTypes.RACE
	name = "race"
	return

func as_random_selector():
	type = Runtime.TNodeTypes.RANDOM_SELECTOR
	name = "random_selector"
	return

func as_random_sequence():
	type = Runtime.TNodeTypes.RANDOM_SEQUENCE
	name = "random_sequence"
	return

func label():
	var l = Label.new()
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT 
	l.text = str(get_child_count())
	return l

func add_pressed():
	get_parent().gd_add_slot(name)
	return

func del_pressed():
	get_parent().gd_del_slot(name)
	return

func get_data():
	return {
		"count" : out_count(),
		"offset" : position_offset, #ivo
		"size": size
	}

func out_count():
	var c = 0
	for i in get_children():
		if  i is Label:
			c += 1
	return c

func set_data(data):
	size = data.size
	position_offset = data.offset #ivo
	for i in range(data.count):
		add_child(label())
		set_slot(get_child_count() - 1, false, 0, Color.BLUE, true, 0, Color.BLUE, null, null)
	return

func delete_request(): #ivo 4.2
	get_parent().child_delete(self)
	return
