extends Node

enum MOVE_MODE {
	TOUCH,
	VIRTUAL_JOYSTICK,
	KEYBOARD,
	KEYBOARD_MOUSE,
	JOYSTICK,
}

var move_mode : MOVE_MODE = MOVE_MODE.KEYBOARD_MOUSE
var is_fog : bool = true
