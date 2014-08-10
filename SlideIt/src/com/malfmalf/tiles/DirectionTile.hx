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
	override public function onEnterEnd(block:Block) {
			block.move = direction;
	}
	
}