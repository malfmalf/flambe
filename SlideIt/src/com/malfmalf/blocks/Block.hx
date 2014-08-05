package com.malfmalf.blocks ;
import flambe.animation.Ease;
import flambe.Component;
import flambe.display.Sprite;
import flambe.math.Point;
import com.malfmalf.scenes.GameScene;
/**
 * ...
 * @author ...
 */

enum MoveDirection {
	NONE;
	LEFT;
	RIGHT;
	UP;
	DOWN;
}
 
class Block extends Component{
	public var coord(default, null):BoardCoord;
	public var pos(default, null):Point;
	public var move:MoveDirection;
	private var waitingForBlock:Block;
	public function new(c:BoardCoord, p:Point) {
		coord = c;
		pos = p;		
		move = MoveDirection.NONE;
	}
	override public function onUpdate(dt:Float) {
		if (move == NONE) {
			waitingForBlock = null;
			return;
		}
		var spr = owner.get(Sprite);
		var moving = (spr.x.behavior != null && !spr.x.behavior.isComplete()) || (spr.y.behavior != null && !spr.y.behavior.isComplete());
		if (!moving) {
			var tile = GameScene.board.getTile(coord);
			tile.onEnterEnd(this);
			var new_coord:BoardCoord;
			switch(move) {
				case NONE:   trace("UH?"); new_coord = coord;
				case LEFT:   new_coord = coord.left();
				case RIGHT:  new_coord = coord.right();
				case UP:     new_coord = coord.up();
				case DOWN:   new_coord = coord.down();
			}
			if (!GameScene.board.isValid(new_coord)) {
				coord = new_coord;
				onFall();
				return;
			}
			var new_tile = GameScene.board.getTile(new_coord);
			new_tile.onEnterStart(this);
			var new_block = GameScene.board.getBlock(new_coord);
			if (new_block != null) {
				if (new_block == waitingForBlock) {
					move = NONE;
				}
				else if ( new_block.move != move) {
					move = NONE;
				}
				else {
					waitingForBlock = new_block;
				}
			}
			else {
				waitingForBlock = null;
			}
			trace("Start move : " + move+" new_tile=" + new_tile+" new_block=" + new_block + "waitingFor=" + waitingForBlock);
			if (move != NONE && waitingForBlock==null) {
				waitingForBlock = null;
				coord = new_coord;
				var p = GameScene.board.getLocalTilePosition(coord);
				spr.x.animateTo(p.x, Constants.moveDuration, Ease.linear);
				spr.y.animateTo(p.y, Constants.moveDuration, Ease.linear);
			}
		}
	}
	public function onFall() {
		move = NONE;
		var spr = owner.get(Sprite);
		spr.scaleX.animateTo(0.1, 0.5);
		spr.scaleY.animateTo(0.1, 0.5);
		spr.scaleX.behavior.
	}
}