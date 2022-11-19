package;

import flixel.system.FlxBGSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.FlxSprite;

using StringTools;

class ControlsSubState extends MusicBeatSubstate
{
	var curSelected:Int = 0;
	var onLeftSide:Bool = true;
	var texts:FlxTypedGroup<FlxControlText>;
	var waitingForKeyPress:Bool = false;

	var elapsedTime:Float = 0.0; // to fix a weird fukcing thing

	var lengthOfControls:Int = 4; // i could prob do better but good for now
	var formattedControls:Map<String, String> = [
		"note_0" => "Left Note",
		"note_1" => "Down Note",
		"note_2" => "Up Note",
		"note_3" => "Right Note"
	];
	var orderedArray:Array<String> = ["note_0", "note_1", "note_2", "note_3"]; // stupid that i have to do this

	public function new(BGColor:FlxColor = FlxColor.TRANSPARENT)
	{
		super();
		closeCallback = null;
		openCallback = null;

		if (FlxG.renderTile)
			_bgSprite = new FlxBGSprite();
		bgColor = BGColor;

		texts = new FlxTypedGroup<FlxControlText>();
		add(texts); // this was really annoying
		for (key in orderedArray)
		{
			var indexInLoop = orderedArray.indexOf(key);
			var formattedKeyName = formattedControls.get(key);
			var valueKey = SaveData.controls.get(key);
			var text = new FlxControlText(0, 130
				+ (indexInLoop * (150 / (lengthOfControls - 3))), 1280,
				formattedKeyName
				+ ": "
				+ valueKey[0].toString() + " | " + valueKey[1].toString()); // this looks horrible
			text.defaultControlText = text.text;
			text.setFormat(Paths.font("vcr.ttf"), 48, 0xffffffff, CENTER, OUTLINE, 0xFF000000);
			text.borderSize = 2;
			texts.add(text);
		}
		changeSelection();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (elapsedTime < 0.1)
		{
			elapsedTime += elapsed;
			return;
		}
		if (!waitingForKeyPress)
		{
			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.8);
				close();
			}
			else if (controls.ACCEPT)
				startRebinding();
			else if (onLeftSide && controls.RIGHT_P || !onLeftSide && controls.LEFT_P)
				flipSide();
			else if (controls.UP_P)
				changeSelection(-1);
			else if (controls.DOWN_P)
				changeSelection(1);
		}
		else if (FlxG.keys.firstJustPressed() != -1)
		{
			var indexArray = (onLeftSide) ? 0 : 1;
			var newKey = FlxG.keys.firstJustPressed();
			for (i in 0...orderedArray.length)
			{
				var keys = SaveData.controls.get(orderedArray[i]);
				for (k in keys)
				{
					if (curSelected == i && keys.indexOf(k) == indexArray)
						continue;
					if (k == newKey)
					{
						if (keys.indexOf(k) > 0)
							SaveData.controls.set(orderedArray[i], [keys[0], SaveData.defaultControls.get(orderedArray[i])[1]]);
						else
							SaveData.controls.set(orderedArray[i], [NONE, keys[1]]);
					}
				}
			}
			var keys:Array<FlxKey> = [];
			keys[1 - indexArray] = SaveData.controls.get(orderedArray[curSelected])[1 - indexArray];
			keys[indexArray] = newKey;
			SaveData.controls.set(orderedArray[curSelected], keys);
			refreshText(true);
			waitingForKeyPress = false;
			SaveData.saveData();
		}
	}

	function startRebinding()
	{
		FlxG.sound.play(Paths.sound('confirmMenu'));
		waitingForKeyPress = true;
		var formattedKeyName = formattedControls.get(orderedArray[curSelected]);
		var valueKey = SaveData.controls.get(orderedArray[curSelected]);
		if (onLeftSide)
			texts.members[curSelected].text = "> " + formattedKeyName + ": ? | " + valueKey[1].toString();
		else
			texts.members[curSelected].text = formattedKeyName + ": " + valueKey[0].toString() + " | ? <";
	}

	function flipSide()
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);

		onLeftSide = !onLeftSide;
		changeSelection(0);
	}

	function changeSelection(amount:Int = 0)
	{
		curSelected += amount;
		if (amount != 0)
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
		if (curSelected < 0)
			curSelected = lengthOfControls - 1;
		if (curSelected >= lengthOfControls)
			curSelected = 0;
		refreshText();
	}

	function refreshText(fullReset:Bool = false)
	{
		if (fullReset)
		{
			for (key in orderedArray)
			{
				var formattedKeyName = formattedControls.get(key);
				var valueKey = SaveData.controls.get(key);
				var text = formattedKeyName + ": " + valueKey[0].toString() + " | " + valueKey[1].toString();
				texts.members[orderedArray.indexOf(key)].defaultControlText = text;
				texts.members[orderedArray.indexOf(key)].text = text;
			}
			refreshText();
			return;
		}
		for (text in texts)
		{
			text.text = text.defaultControlText;
		}
		if (onLeftSide)
			texts.members[curSelected].text = "> " + texts.members[curSelected].defaultControlText;
		else
			texts.members[curSelected].text = texts.members[curSelected].defaultControlText + " <";
	}
}

class FlxControlText extends FlxText
{
	public var defaultControlText = "";
}
