package com.malfmalf;
import flambe.display.Graphics;
import flambe.display.Texture;

/**
 * ...
 * @author ...
 */
class AnimationSheet{
	public var texture(default,null):Texture;
	public var frameWidth(default,null):Int;
	public var frameHeight(default, null):Int;
	public var numHorizontalFrames(default, null):Int;
	public var numVerticalFrames(default, null):Int;
	
	public function new(texture:Texture,frameWidth = 0,frameHeight = 0) {
		this.texture = texture;
		this.frameWidth = frameWidth;
		this.frameHeight = frameHeight;
		if (frameWidth <= 0) this.frameWidth = texture.width;
		if (frameHeight <= 0) this.frameHeight = texture.height;
		numHorizontalFrames = Math.floor(texture.width /  this.frameWidth);
		numVerticalFrames   = Math.floor(texture.height / this.frameHeight);
	}
	public function drawFrameIJ(g:Graphics , destX:Float , destY:Float, i:Int, j:Int):Void {
		g.drawSubTexture(texture, destX, destY, i * frameWidth, j * frameHeight, frameWidth, frameHeight);
	}
	public function drawFrame(g:Graphics , destX:Float , destY:Float, id:Int):Void {
		drawFrameIJ(g, destX, destY, id % numHorizontalFrames, Std.int(id / numHorizontalFrames));
	}
}