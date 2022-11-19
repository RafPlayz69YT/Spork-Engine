package;

import flixel.FlxG;
import lime.app.Application;
import flixel.input.keyboard.FlxKey;

class SaveData // the formatter is a bit weird so the save file looks a bit weird (tried to get along with the formatter)
{
	// save file naming stuff
	public static var saveLocation(get, null):String;
	public static var saveFileName(default, null):String = "funkin"; // the actual file name

	static function get_saveLocation():String
	{
		var defSaveLocation:String = "ninjamuffin99"; // maybe i should set this to the company?
		#if (flixel >= "5.0.0")
		defSaveLocation = Application.current.meta.get('company') + "/" + defSaveLocation;
		#end

		return defSaveLocation;
	}

	// actual save file stuff
	public static var controls:Map<String, Array<FlxKey>> = [
		"note_0" => [A, LEFT],
		"note_1" => [S, DOWN],
		"note_2" => [W, UP],
		"note_3" => [D, RIGHT]
	]; // code inspired by psych
	public static var defaultControls:Map<String, Array<FlxKey>> = [
		"note_0" => [A, LEFT],
		"note_1" => [S, DOWN],
		"note_2" => [W, UP],
		"note_3" => [D, RIGHT]
	];
	public static var ghostTapping:Bool = true;

	// public static var saveData:Map<String,Dynamic>= []; dont know if i should use this for dynamic save data???

	public static function getNoteControl(noteData:Int) // make code look nice
	{
		var keyArray:Array<FlxKey> = [];

		if (controls.exists("note_" + (noteData % 4)))
			keyArray = controls.get("note_" + (noteData % 4));
		return keyArray;
	}

	public static function saveData()
	{
		FlxG.save.data.controls = controls;
		FlxG.save.data.ghostTapping = ghostTapping;
	}

	public static function loadData()
	{
		if (FlxG.save.data.controls != null)
		{
			controls = FlxG.save.data.controls;
		}
		if (FlxG.save.data.ghostTapping != null)
		{
			ghostTapping = FlxG.save.data.ghostTapping;
		}
	}
}
