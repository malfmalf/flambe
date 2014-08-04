package com.malfmalf;
import haxe.ds.HashMap;
import flambe.display.Graphics;
/**
 * ...
 * @author ...
 */
class AnimationManager{
	public var animationSheet(default,null):AnimationSheet;
	private var animations:Array<Animation>;
	private var animationIndex:Map<String,Int>;
	private var currentAnimationId:Int;
	public var currentAnimation(get_currentAnimation, null):Animation;
	public function new(animationSheet:AnimationSheet) {
		this.animationSheet = animationSheet;
		clearAnimations();
	}
	public function clearAnimations():Void {
		animations = [ new Animation(animationSheet, [0], 0.0, false) ];
		animationIndex = [ "default" =>0 ];
		currentAnimationId = 0;
	}
	public function addAnimation(name:String,animation:Animation):Int {
		animations.push(animation);
		animationIndex.set(name, animations.length - 1);
		return animations.length - 1;
	}
	public function setCurrentAnimationById(id:Int) {
		if (id<0 ||id>=animations.length) return;
		currentAnimationId = id;
	}
	public function setCurrentAnimation(name:String) {
		var id = animationIndex.get(name);
		if (id == null) return;
		setCurrentAnimationById(id);
	}
	public function get_currentAnimation():Animation {
		return animations[currentAnimationId];
	}
	public function onUpdate(dt:Float) {
		currentAnimation.onUpdate(dt);
	}
	public function drawFrame(g:Graphics , destX:Float , destY:Float):Void {
		currentAnimation.drawFrame(g, destX, destY);
	}

	
	
}