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
	public function new(d:MoveDirection,c:BoardCoord, p:Point,textureId:Int) {
		super(c, p,textureId);
		direction = d;
	}
	override public function onAdded () {
		var name:String;
		switch(direction) {
			case MoveDirection.LEFT : name = "Left";
			case MoveDirection.RIGHT: name = "Right";
			case MoveDirection.UP   : name = "Up";
			case MoveDirection.DOWN : name = "Down";
			default:trace("UH?"); name = "error";
		}
		var manager = new AnimationManager(new AnimationSheet(Main.elements.getCut("tile" + name), 128, 128));
		var animation = Animation.allFramesAnimation(manager.animationSheet, 8.0, true, true);
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