package;

import flixel.FlxGame;
import flixel.math.FlxMath;
import openfl.display.Sprite;

class ExperienceModule
{
	public var level:Int = 1;
	public var experience:Int = 5;

	// variable that stores function to call when level up occurs
	public var onLevelUp:Void->Void;

	public function new() {}

	public function gainExperience(amount:Int):Void
	{
		experience += amount;
		if (experience >= calculateMaxExperience())
		{
			levelUp();
		}
	}

	public function levelUp():Void
	{
		level++;
		experience -= calculateMaxExperience();

		onLevelUp();
	}

	public function setOnLevelUpFunction(levelUpFunction:Void->Void)
	{
		onLevelUp = levelUpFunction;
	}

	public function calculateMaxExperience():Int
	{
		return 15 + level * 5;
	}
}
