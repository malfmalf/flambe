package com.malfmalf;
import flambe.util.Signal0;
import flambe.display.Graphics;

/**
 * ...
 * @author ...
 */
typedef FrameList = Array<Int>;

class Animation{
	private var animationSheet:AnimationSheet;
	public var frames(default,null):FrameList;
	private var currentFrame:Int;
	private var loop:Bool;
	private var timeBetweenFrames:Float;
	private var accumulatedTime:Float;
	public var onFinished(default, null):Signal0;
	public var finished:Bool;
	public function new(animationSheet:AnimationSheet,frames:FrameList,fps:Float,loop = true) {
		this.animationSheet = animationSheet;
		this.frames = frames;
		this.loop = loop;
		this.timeBetweenFrames = fps>0.0 ? 1.0/fps : -1.0;
		onFinished = new Signal0();
		reset();
	}
	public function reset():Void {
		currentFrame = 0;
		accumulatedTime = 0.0;
		finished = false;		
	}
	public function onUpdate(dt:Float) {
		if (finished) return;
		if (timeBetweenFrames <= 0.0) {
			++currentFrame;
		}
		else {
			accumulatedTime += dt;
			if (accumulatedTime > timeBetweenFrames) {
				accumulatedTime -= timeBetweenFrames;
				++currentFrame;
			}
		}
		if (currentFrame >= frames.length) {
			if (loop) {
				currentFrame = 0;
			}
			else {
				currentFrame = frames.length - 1;
				finished = true;
				onFinished.emit();
			}
		}
	}
	public function drawFrame(g:Graphics , destX:Float , destY:Float):Void {
		animationSheet.drawFrame(g, destX, destY, frames[currentFrame]);
	}
	
	public static function allFramesAnimation(animationSheet:AnimationSheet, fps:Float, loop = false, bounce = false) {
		var num = animationSheet.numHorizontalFrames * animationSheet.numVerticalFrames;
		var frames = [for (i in 0...num) i];
		if (bounce) {
			var bounce_frames = [for (i in 0...num - 1) num - i - 1];
			if (!loop) bounce_frames.push(0);
			frames = frames.concat(bounce_frames);
		}
		return new Animation(animationSheet, frames, fps, loop);
	}
}