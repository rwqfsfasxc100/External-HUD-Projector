extends Label

var dir = Directory.new()
var file = File.new()

var sensor_dir = ""

func _ready():
	var base_dir = ProjectSettings.globalize_path("user://")
	var appdata = base_dir.rsplit("external_hud_projector/")
	sensor_dir = appdata[0] + "dV/cache/.ExternalHUD_Cache/text_sensors/sensor_%s"
	

var status = {}

var sensors = [
	"cargo.value",
	"return.fuel",
	"return.fuel.xenon",
	"return.time",
	"return.time.xenon",
	"mass",
	"fuel",
	"fuel.special",
	"ammo",
	"drones",
	"cargoMass",
	"cargoCapacity",
	"power_balance",
	"power_draw",
	"power_supply",
	"internalCapacitor",
	"internalCapacitor.capacity",
	"capacitor",
	"diveDepth",
	"reactor_temperature",
	"reactor_temperature/1",
	"reactor_temperature/2",
	"velocity",
	"acceleration",
	"bearing",
	"orientation",
	"escape_trajectory",
	"trajectory",
	"dv",
	"status",
	"rw_rpm",
	"proximityAlert",
	"proximityAlert.astrogation",
	"autopilot.velocity",
	"autopilot.bearing",
	"autopilot.orientation",
	"autopilot.acceleration",
	"temporaryCargo.weapon-left-back",
	"temporaryCargo.weapon-left-back2",
	"temporaryCargo.weapon-left-back3",
	"temporaryCargo.weapon-right-back",
	"temporaryCargo.weapon-right-back2",
	"temporaryCargo.weapon-right-back3",
]

var toggle = true
var count = 0
func _physics_process(delta):
	count += 1
	if count % 2 == 0:
		var display = ""
		var sdta = ExternalHUD_Network.get_sensor_info()
		for sensor in sdta:
			var val = sdta[sensor]
			
			
			if val == null:
				val = "------"
			if display == "":
				display = TranslationServer.translate(sensor + "_SENSOR") + ": " + str(val)
			else:
				display = display + "\n" + TranslationServer.translate(sensor + "_SENSOR") + ": " + str(val)
						
					
		text = display
#	toggle = !toggle



func fetch(folder):
	var fileList = []
	
#	folder = ProjectSettings.localize_path(folder)
	var does = dir.dir_exists(folder)
	if not does:
		return []
	dir.open(folder)
	var dirName = dir.get_current_dir()
	dir.list_dir_begin(true)
	while true:
		var fileName = dir.get_next()
		var capture = true
		if fileName.ends_with("/"):
			capture = false
		if fileName == "." or fileName == "..":
			capture = false
		if capture:
			dirName = dir.get_current_dir()
#			Debug.l(fileName)
			if fileName == "":
				break
			if dir.current_is_dir():
				continue
			
			fileName = folder + fileName
			fileList.append(ProjectSettings.globalize_path(fileName))
	return fileList
