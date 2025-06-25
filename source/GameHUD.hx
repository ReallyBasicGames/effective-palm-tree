package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GameHUD extends FlxGroup
{
	// Layout variables
	private var margin:Int = 10;
	private var playerBoxSize:Int = 60;
	private var healthBarWidth:Int = 200;
	private var healthBarHeight:Int;
	private var expBarWidth:Int;
	private var expBarHeight:Int;
	private var barPadding:Int = 4;

	// Main UI components
	private var playerBox:FlxSprite;
	private var healthBarBG:FlxSprite;
	private var healthBarFill:FlxSprite;
	private var healthLabel:FlxText;
	private var expBarBG:FlxSprite;
	private var expBarFill:FlxSprite;
	private var levelLabel:FlxText;

	public function new()
	{
		super();
		healthBarHeight = Std.int(playerBoxSize / 2);
		expBarWidth = healthBarWidth;
		expBarHeight = Std.int(playerBoxSize / 3);
		createUI();
	}

	private function createUI():Void
	{
		// Player box
		playerBox = new FlxSprite(margin, margin);
		playerBox.makeGraphic(playerBoxSize, playerBoxSize, FlxColor.GRAY);
		add(playerBox);

		// Health bar background
		var healthBarX = margin + playerBoxSize;
		var healthBarY = margin;
		healthBarBG = new FlxSprite(healthBarX, healthBarY);
		healthBarBG.makeGraphic(healthBarWidth, healthBarHeight, FlxColor.GRAY);
		add(healthBarBG);

		// Health bar fill (with padding)
		healthBarFill = new FlxSprite(healthBarX + barPadding, healthBarY + barPadding);
		healthBarFill.makeGraphic(healthBarWidth - 2 * barPadding, healthBarHeight - 2 * barPadding, FlxColor.RED);
		add(healthBarFill);

		// Health label (centered on health bar)
		healthLabel = new FlxText(healthBarX, healthBarY, healthBarWidth, "12/20");
		healthLabel.setFormat(null, 14, FlxColor.WHITE, "center");
		healthLabel.y += (healthBarHeight - healthLabel.height) / 2;
		add(healthLabel);

		// Experience bar background (directly below health bar)
		var expBarX = healthBarX;
		var expBarY = healthBarY + healthBarHeight;
		expBarBG = new FlxSprite(expBarX, expBarY);
		expBarBG.makeGraphic(expBarWidth, expBarHeight, FlxColor.GRAY);
		add(expBarBG);

		// Experience bar fill (with padding)
		expBarFill = new FlxSprite(expBarX + barPadding, expBarY + barPadding);
		expBarFill.makeGraphic(expBarWidth - 2 * barPadding, expBarHeight - 2 * barPadding, FlxColor.YELLOW);
		add(expBarFill);

		// Level label (bottom left of player box)
		levelLabel = new FlxText(margin + 4, margin + playerBoxSize - 18, 50, "L. 1");
		levelLabel.setFormat(null, 14, FlxColor.WHITE);
		add(levelLabel);
	}

	public function updateHUD():Void
	{
		updateHealthBar();
		updateExpBar();
	}

	private function updateHealthBar():Void
	{
		var currentHealth = Player.getCurrentHealth();
		var maxHealth = Player.getMaxHealth();
		var healthPercentage = currentHealth / maxHealth;
		var fillWidth = Std.int((healthBarWidth - 2 * barPadding) * healthPercentage);
		healthBarFill.makeGraphic(Std.int(Math.max(1, fillWidth)), healthBarHeight - 2 * barPadding, FlxColor.RED);
		healthLabel.text = currentHealth + "/" + maxHealth;
	}

	private function updateExpBar():Void
	{
		var currentExp = Player.getCurrentExp();
		var maxExp = Player.getMaxExp();
		var level = Player.getLevel();
		var expPercentage = currentExp / maxExp;
		var fillWidth = Std.int((expBarWidth - 2 * barPadding) * expPercentage);
		expBarFill.makeGraphic(Std.int(Math.max(1, fillWidth)), expBarHeight - 2 * barPadding, FlxColor.YELLOW);
		levelLabel.text = "L. " + level;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		updateHUD();
	}
}
