package;

import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		add(new FlxText("Hello World!", 32).screenCenter());
		add(new FlxText("V" + Main.VERSION, 12));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
