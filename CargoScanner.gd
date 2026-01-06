extends TextureRect

export (String,"visual.cargo_bay_scanner","visual.remote_scanner") var specific_scanner = "visual.cargo_bay_scanner"

var scannerdir = ""
var dir = Directory.new()
var png = ""

var flip = false

func _ready():
	var path = ProjectSettings.globalize_path("user://")
	scannerdir = path.rstrip("external_hud_projector/") + "/dV/cache/.ExternalHUD_Cache/visual_sensors/" + specific_scanner + "/"
	

func _physics_process(delta):
	pass
	var files = __fetch_folder_files(scannerdir)
	if files.size() > 8:
		var tex = load_external_tex(scannerdir + files[4])
		texture = tex
	else:
		texture = null

func load_external_tex(path):
	var tex_file = File.new()
	tex_file.open(path, File.READ)
	var bytes = tex_file.get_buffer(tex_file.get_len())
	var img = Image.new()
	var data = img.load_png_from_buffer(bytes)
	var imgtex = ImageTexture.new()
	imgtex.create_from_image(img)
	tex_file.close()
	return imgtex






static func __fetch_folder_files(folder, showFolders = false, returnFullPath = false,globalizePath = false):
#	Debug.l("HevLib: function 'fetch_folder_files' instanced in %s, with folders included? [%s]" % [folder, showFolders])
	var fileList = []
	var dir = Directory.new()
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
			if dir.current_is_dir() and not showFolders:
				continue
			elif dir.current_is_dir() and showFolders and not fileName.ends_with("/"):
				fileName = fileName + "/"
			if returnFullPath:
				fileName = folder + fileName
			if globalizePath:
				fileList.append(ProjectSettings.globalize_path(fileName))
			else:
				fileList.append(fileName)
	
	
	
#	m = m.split(m.split("/")[0] + "/")[1].to_lower()
	var dFiles = ""
	for m in fileList:
		if dFiles == "":
			dFiles = m
		else:
			dFiles = dFiles + ", " + m
#	Debug.l("HevLib: fetch_folder_files returning as %s" % dFiles)
	return fileList
