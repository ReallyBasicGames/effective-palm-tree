package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.math.FlxMath;
import openfl.display.Sprite;

class Player extends Sprite
{
	public static final BASE_HEALTH:Int = 20;
	public static final BASE_ATTACK:Int = 1;
	public static final BASE_DEFENSE:Int = 1;
	public static var attack:Int = 1;

	static var experience:ExperienceModule;
	static var healthModule:HealthModule;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
		attack = BASE_ATTACK;
		healthModule = new HealthModule(BASE_HEALTH, BASE_DEFENSE);
		healthModule.onDeath = die;
		experience = new ExperienceModule();
		experience.onLevelUp = levelUp;
	}

	public static function gainExperience(amount:Int):Void
	{
		experience.gainExperience(amount);
	}

	public static function levelUp():Void
	{
		switch (FlxMath.mod(experience.level, 3))
		{
			case 0:
				healthModule.setDefense(healthModule.defense + 1);
			case 1:
				attack++;
			case 2:
				healthModule.setMaxHealth(healthModule.maxHealth + 5);
				healthModule.heal(5); // Also heal the player when max health increases
		}
	}

	public static function damageMe(damage:Int)
	{
		healthModule.takeDamage(damage);
	}

	// Getter methods for HUD access
	public static function getCurrentHealth():Int
	{
		return healthModule.currentHealth;
	}

	public static function getMaxHealth():Int
	{
		return healthModule.maxHealth;
	}

	public static function getCurrentExp():Int
	{
		return experience.experience;
	}

	public static function getMaxExp():Int
	{
		return experience.calculateMaxExperience();
	}

	public static function getLevel():Int
	{
		return experience.level;
	}

	public static function die()
	{
		trace("You died!");
		FlxG.switchState(PlayState.new);
	}
}
