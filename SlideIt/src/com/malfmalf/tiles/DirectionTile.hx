package com.malfmalf.tiles ;
import com.malfmalf.blocks.Block.MoveDirection;
import com.malfmalf.blocks.Block;
import flambe.animation.Ease;
import flambe.math.Point;
import flambe.display.ImageSprite;
import flambe.script.AnimateTo;
import flambe.script.Parallel;
import flambe.script.Repeat;
import flambe.script.Script;
import flambe.script.Sequence;
import flambe.script.Shake;
import com.malfmalf.AnimationManager;
import com.malfmalf.Animation;

/**
 * ...
 * @author ...
 */
class DirectionTile extends Tile
{
	public var direction(default, null):MoveDirection;
	public function new(d:MoveDirection,c:BoardCoord, p:Point) {
		super(c, p);
		direction = d;
	}
	override public function onAdded () {
		var name:String;
		switch(direction) {
			case MoveDirection.LEFT : name = "leftFrames";
			case MoveDirection.RIGHT: name = "rightFrames";
			case MoveDirection.UP   : name = "upFrames";
			case MoveDirection.DOWN : name = "downFrames";
			default:trace("UH?"); name = "error";
		}
		var manager = new AnimationManager(new AnimationSheet(Main.boardPack.getTexture("img/tiles/" + name), 64, 64));
		var animation = Animation.allFramesAnimation(manager.animationSheet, 8.0, true, true);
		trace(animation.frames);
		manager.addAnimation("main", animation);
		manager.setCurrentAnimation("main");
		var sprite = new AnimatedSprite(manager).centerAnchor();
		sprite.setXY(pos.x, pos.y);
		owner.add(sprite);
	}
	override public function onEnterEnd(block:Block) {
			block.move = direction;
	}
	
}