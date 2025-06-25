package;

import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	// In PlayState.hx
	var hud:GameHUD;
	var player:Player;

	override public function create():Void
	{
		super.create();

		// Create and add HUD
		player = new Player();
		hud = new GameHUD();
		// add(new FlxText("V" + Main.VERSION, 12));
		add(hud);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
