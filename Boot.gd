extends Control


func _ready():
	updateTL_from_dictionary(load("res://i18n/en.gd").get_script_constant_map()["data"])
	pass




static func updateTL_from_dictionary(path:Dictionary):
	
	
	var translations := []
	var translationCount = 0
	
	for lang in path.keys():
		var translationObject := Translation.new()
		translationObject.locale = lang
		var translation_dict = path.get(lang)
		var tKeys = translation_dict.keys()
		for key in tKeys:
			var data = translation_dict.get(key)
			translationObject.add_message(key,data.c_unescape())
			
		translationCount += 1
		
		translations.append(translationObject)
	for translationObject in translations:
		TranslationServer.add_translation(translationObject)
	
