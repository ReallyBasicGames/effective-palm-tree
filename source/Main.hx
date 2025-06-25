package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static final VERSION:String = "0.0.2";

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
