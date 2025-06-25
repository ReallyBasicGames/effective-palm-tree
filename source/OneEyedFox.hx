package;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class OneEyedFox extends Enemy
{
	public function new(x:Float = 0, y:Float = 0)
	{
		// Set OneEyedFox-specific base stats before calling super
		baseHealth = 3;
		baseDefense = 1;
		baseAttack = 1;
		baseExperienceReward = 3;

		super(x, y);

		// Set up sprite appearance - orange fox
		makeGraphic(16, 16, FlxColor.ORANGE);
	}

	public function onLevelUp():Void
	{
		// OneEyedFox level up behavior - simple growth pattern
		switch (FlxMath.mod(experienceModule.level, 2))
		{
			case 0:
				// Increase attack
				attack++;
			case 1:
				// Increase max health and heal
				healthModule.setMaxHealth(healthModule.maxHealth + 2);
				healthModule.heal(2);
		}
	}

	public function updateAI():Void
	{
		// Simple AI: OneEyedFox has a 5% chance per frame to attack
		if (FlxG.random.bool(5))
		{
			attackPlayer();
		}
	}

	override public function onDeath():Void
	{
		// Custom death behavior for OneEyedFox
		trace("OneEyedFox defeated!");

		// Call parent death behavior (gives experience to player)
		super.onDeath();
	}

	override public function onDamage(actualDamage:Int):Void
	{
		// Custom damage behavior for OneEyedFox
		trace("OneEyedFox took " + actualDamage + " damage!");
	}
}
