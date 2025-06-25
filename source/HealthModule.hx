package;

import flixel.FlxGame;
import flixel.math.FlxMath;
import openfl.display.Sprite;

class HealthModule
{
	public var maxHealth:Int = 20;
	public var currentHealth:Int = 20;
	public var defense:Int = 1;

	// variable that stores function to call when health reaches zero
	public var onDeath:Void->Void;

	// variable that stores function to call when damage is taken
	public var onDamage:Int->Void;

	// variable that stores function to call when health is restored
	public var onHeal:Int->Void;

	public function new(maxHealth:Int = 20, defense:Int = 1)
	{
		this.maxHealth = maxHealth;
		this.currentHealth = maxHealth;
		this.defense = defense;
	}

	public function takeDamage(damage:Int):Void
	{
		var actualDamage = Std.int(Math.max(damage - defense, 0));
		currentHealth -= actualDamage;

		if (onDamage != null)
			onDamage(actualDamage);

		if (currentHealth <= 0)
		{
			currentHealth = 0;
			if (onDeath != null)
				onDeath();
		}
	}

	public function heal(amount:Int):Void
	{
		var previousHealth = currentHealth;
		currentHealth = Std.int(Math.min(currentHealth + amount, maxHealth));
		var actualHeal = currentHealth - previousHealth;

		if (onHeal != null && actualHeal > 0)
			onHeal(actualHeal);
	}

	public function setMaxHealth(newMaxHealth:Int):Void
	{
		maxHealth = newMaxHealth;
		// Optionally adjust current health if it exceeds new max
		if (currentHealth > maxHealth)
			currentHealth = maxHealth;
	}

	public function setDefense(newDefense:Int):Void
	{
		defense = newDefense;
	}

	public function isDead():Bool
	{
		return currentHealth <= 0;
	}

	public function isFullHealth():Bool
	{
		return currentHealth >= maxHealth;
	}

	public function getHealthPercentage():Float
	{
		return currentHealth / maxHealth;
	}

	public function setOnDeathFunction(deathFunction:Void->Void):Void
	{
		onDeath = deathFunction;
	}

	public function setOnDamageFunction(damageFunction:Int->Void):Void
	{
		onDamage = damageFunction;
	}

	public function setOnHealFunction(healFunction:Int->Void):Void
	{
		onHeal = healFunction;
	}
}
