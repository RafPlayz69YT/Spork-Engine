package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpControls:FlxTypedGroup<Alphabet>;
	var textMenuItems:Array<String> = [/*'Master Volume', 'Sound Volume',*/ 'Controls', "Ghost Tapping"];

	public function new()
	{
		super();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			changeSelection(-1);

		if (controls.DOWN_P)
			changeSelection(1);

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				case "Controls":
					persistentUpdate = false;
					persistentDraw = true;
					openSubState(new ControlsSubState(0x99000000));
				case "Ghost Tapping":
					SaveData.ghostTapping = !SaveData.ghostTapping;
					reloadText();
			}
		}
	}

	override function create()
	{
		SaveData.loadData();
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...textMenuItems.length)
		{
			var controlLabel:Alphabet = null;
			if (i > 0)
				controlLabel = new Alphabet(0, (70 * i) + 30, textMenuItems[i] + ((!SaveData.ghostTapping) ? " Off" : " On"), true, false);
			else
				controlLabel = new Alphabet(0, (70 * i) + 30, textMenuItems[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
		}
		changeSelection(0);
		super.create();
	}

	function reloadText()
	{
		for (text in grpControls)
		{
			grpControls.remove(text);
		}
		for (i in 0...textMenuItems.length)
		{
			var controlLabel:Alphabet = null;
			if (i > 0)
				controlLabel = new Alphabet(0, (70 * i) + 30, textMenuItems[i] + ((!SaveData.ghostTapping) ? " Off" : " On"), true, false);
			else
				controlLabel = new Alphabet(0, (70 * i) + 30, textMenuItems[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
		}
		changeSelection(0);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
