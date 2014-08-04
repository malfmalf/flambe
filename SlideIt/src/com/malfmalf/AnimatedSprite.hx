package com.malfmalf;
import flambe.display.Sprite;
import flambe.display.Graphics;

/**
 * A fixed-size sprite that displays a single texture.
 */
class AnimatedSprite extends Sprite
{
    /**
     * The texture being displayed, or null if none.
     */
    public var animationManager :AnimationManager;

    public function new (animationManager :AnimationManager)
    {
        super();
        this.animationManager = animationManager;
    }

    override public function draw (g :Graphics)
    {
        if (animationManager != null && animationManager.animationSheet !=null) {
            animationManager.drawFrame(g, 0, 0);
        }
    }

    override public function getNaturalWidth () :Float
    {
        return (animationManager != null && animationManager.animationSheet !=null) ? animationManager.animationSheet.frameWidth : 0;
    }

    override public function getNaturalHeight () :Float
    {
        return (animationManager != null && animationManager.animationSheet !=null) ? animationManager.animationSheet.frameHeight : 0;
    }
    override public function onUpdate(dt:Float)
    {
		super.onUpdate(dt);
		animationManager.onUpdate(dt);
	}
}
