package;

import flixel.FlxSprite;
import flixel.math.FlxMath;

abstract class Enemy extends FlxSprite
{
	public var healthModule:HealthModule;
	public var experienceModule:ExperienceModule;
	public var attack:Int;
	public var experienceReward:Int; // Experience given to player when defeated

	// Base stats that can be overridden by subclasses
	public var baseHealth:Int = 10;
	public var baseDefense:Int = 0;
	public var baseAttack:Int = 1;
	public var baseExperienceReward:Int = 5;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		initializeStats();
		setupModules();
	}

	private function initializeStats():Void
	{
		// Subclasses can override this to set different base stats
		attack = baseAttack;
		experienceReward = baseExperienceReward;
	}

	private function setupModules():Void
	{
		// Initialize health module
		healthModule = new HealthModule(baseHealth, baseDefense);
		healthModule.onDeath = onDeath;
		healthModule.onDamage = onDamage;

		// Initialize experience module
		experienceModule = new ExperienceModule();
		experienceModule.onLevelUp = onLevelUp;
	}

	public function takeDamage(damage:Int):Void
	{
		healthModule.takeDamage(damage);
	}

	public function heal(amount:Int):Void
	{
		healthModule.heal(amount);
	}

	public function gainExperience(amount:Int):Void
	{
		experienceModule.gainExperience(amount);
	}

	// Abstract method that must be implemented by subclasses
	public abstract function onLevelUp():Void;

	// Virtual methods that can be overridden by subclasses
	public function onDeath():Void
	{
		// Give experience reward to player
		Player.gainExperience(experienceReward);

		// Default death behavior - remove from game
		kill();
	}

	public function onDamage(actualDamage:Int):Void
	{
		// Default damage behavior - can be overridden for special effects
		// For example: screen shake, damage numbers, sound effects, etc.
	}

	// Combat methods
	public function attackPlayer():Void
	{
		Player.damageMe(attack);
	}

	public function isDead():Bool
	{
		return healthModule.isDead();
	}

	public function isFullHealth():Bool
	{
		return healthModule.isFullHealth();
	}

	public function getHealthPercentage():Float
	{
		return healthModule.getHealthPercentage();
	}

	// AI behavior - to be implemented by subclasses
	public abstract function updateAI():Void;

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (!isDead())
		{
			updateAI();
		}
	}
}
