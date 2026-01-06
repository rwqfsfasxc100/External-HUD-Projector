extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 28641
const MAX_CONNECTIONS = 128

var current_sensors = {}
var current_visuals = {}


func _ready():
	
	create_server()
	get_tree().connect("network_peer_disconnected",self,"_disconnected")

func _disconnected():
	pass

func create_server():
	
	var peer = NetworkedMultiplayerENet.new()
	peer.set_bind_ip(DEFAULT_IP)
	yield(get_tree(),"idle_frame")
	peer.create_server(DEFAULT_PORT,MAX_CONNECTIONS)
	get_tree().set_network_peer(peer)

remote func update_sensor(sensor,mode,value):
	if get_tree().is_network_server():
		match mode:
			"text":
				current_sensors[sensor] = value
			"visual":
				current_visuals[sensor] = str2var(value)

func get_sensor_info():
	return current_sensors

func get_visual_info():
	return current_visuals

remote func wipe_sensor(sensor):
	if sensor in current_sensors:
		current_sensors.erase(sensor)
	if sensor in current_visuals:
		current_visuals.erase(sensor)
