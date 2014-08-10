package com.malfmalf.blocks ;
import com.malfmalf.BoardCoord;
import com.malfmalf.tiles.Tile;
import flambe.animation.Ease;
import flambe.Component;
import flambe.display.Sprite;
import flambe.display.ImageSprite;
import flambe.Disposer;
import flambe.math.Point;
import com.malfmalf.scenes.GameScene;
import flambe.math.Rectangle;
import flambe.script.Script;
using com.malfmalf.PointUtils;
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
	public var next_coord(default, null):BoardCoord;
	private var next_coord_reached:Bool;
	public var pos(default, null):Point;
	private var textureId:Int;
	public var move:MoveDirection;
	private var disposer:Disposer;
	private var willFall:Bool;
	private var falling:Bool;
	public function new(c:BoardCoord, p:Point,textureId:Int) {
		coord = c;
		next_coord = c;
		next_coord_reached = false;
		pos = p;		
		this.textureId = textureId;
		move = MoveDirection.NONE;
		disposer = new Disposer();
		willFall = false;
		falling = false;
		
	}
	override public function onAdded() {
		owner.add(new ImageSprite(Main.elements.getCut(Std.string(textureId))).centerAnchor());
		owner.get(ImageSprite).setXY(pos.x, pos.y);		
	}
	override public function onUpdate(dt:Float) {
		if (falling) {
			var spr = owner.get(Sprite);
			var doing = (spr.scaleX.behavior != null && !spr.scaleX.behavior.isComplete()) || (spr.scaleY.behavior != null && !spr.scaleY.behavior.isComplete());
			if (!doing) {
				GameScene.board.blocks.remove(this);
				owner.disposeChildren();
				owner.dispose();
				onFall();
			}
			return;			
		}
		if (move == NONE) {
			return;
		}
		var spr = owner.get(Sprite);
		var moveDistance = Constants.moveSpeed * dt;
		switch(move) {
			case LEFT : spr.x._ -= moveDistance; 
			case RIGHT: spr.x._ += moveDistance; 
			case UP   : spr.y._ -= moveDistance; 
			case DOWN : spr.y._ += moveDistance; 
			default : trace("UUUH!");
		}
		checkTileMovement(moveDistance);
		var others = GameScene.board.getBlocks(next_coord, this);
		for (other in others) {
			if (overlap(other, moveDistance)) {
				if(other.move!=move)	stop();
			}			
		}
	}
	public function stop() {
		trace("STOP CALLED");
		move = NONE;
		var spr = owner.get(Sprite);
		var p = GameScene.board.getLocalTilePosition(coord);
		spr.setXY(p.x, p.y);
	}
	public function onFall() {
	
	}
	public function manhattan(other:Block):Float {
		var spr  = owner.get(Sprite);
		var ospr = other.owner.get(Sprite);
		return Math.abs(spr.x._ - ospr.x._) +Math.abs(spr.y._ - ospr.y._);
	}
	public function overlap(other:Block,d:Float):Bool {
		var spr  = owner.get(Sprite);
		var ospr = other.owner.get(Sprite);
		switch(move) {
				case LEFT : return Math.abs(spr.x._ - ospr.x._) < Constants.blockSize;
				case RIGHT: return Math.abs(spr.x._ - ospr.x._) < Constants.blockSize;
				case UP   : return Math.abs(spr.y._ - ospr.y._) < Constants.blockSize;
				case DOWN : return Math.abs(spr.y._ - ospr.y._) < Constants.blockSize;
				default:    return false;
		}
	}
	public function left() {
		move = LEFT;
		next_coord = coord.left();
		var next_tile = GameScene.board.getTile(next_coord);
		if(next_tile!=null) next_tile.onEnterStart(this);
		next_coord_reached = false;
	}
	public function right() {
		move = RIGHT;
		next_coord = coord.right();
		var next_tile = GameScene.board.getTile(next_coord);
		if(next_tile!=null) next_tile.onEnterStart(this);
		next_coord_reached = false;
	}
	public function up() {
		move = UP;
		next_coord = coord.up();
		var next_tile = GameScene.board.getTile(next_coord);
		if(next_tile!=null) next_tile.onEnterStart(this);
		next_coord_reached = false;
	}
	public function down() {
		move = DOWN;
		next_coord = coord.down();
		var next_tile = GameScene.board.getTile(next_coord);
		if(next_tile!=null) next_tile.onEnterStart(this);
		next_coord_reached = false;
	}
	public function checkTileMovement(d:Float) {
		if (reached(next_coord)) {
			coord = next_coord;
			if (willFall) {
				trace("FALL at " + next_coord);
				falling = true;
				stop();
				var spr = owner.get(Sprite);
				spr.scaleX.animateTo(0.01, 1.0);
				spr.scaleY.animateTo(0.01, 1.0);
				spr.rotation.animateBy(180.0, 1.0);
				spr.alpha.animateTo(0.2, 1.0);
				return;
			}
			var tile = GameScene.board.getTile(coord);
			if (tile != null) {
				trace("END : " + tile);
				tile.onEnterEnd(this);			
			}
			var p = GameScene.board.getLocalTilePosition(coord);
			var spr  = owner.get(Sprite);
			switch(move) {
				case LEFT : next_coord = coord.left(); spr.y._ = p.y;
				case RIGHT: next_coord = coord.right();spr.y._ = p.y;
				case UP   : next_coord = coord.up();   spr.x._ = p.x;
				case DOWN : next_coord = coord.down(); spr.x._ = p.x;
				case NONE : //na
				default : trace("UUUH!");
			}		
			next_coord_reached = true;
		}
		if (next_coord_reached) {
			var next_tile = GameScene.board.getTile(next_coord);
			if (next_tile != null) {
				trace("ENTER : " + next_tile);
				next_tile.onEnterStart(this);		
			}
			else {
				trace("WILL FALL at " + next_coord);
				willFall = true;
			}
			next_coord_reached = false;
		}
	}
	public function reached(c:BoardCoord):Bool {
		var p = GameScene.board.getLocalTilePosition(c);
		var spr  = owner.get(Sprite);
		switch(move) {
				case LEFT : return spr.x._ <= p.x;
				case RIGHT: return spr.x._ >= p.x;
				case UP   : return spr.y._ <= p.y;
				case DOWN : return spr.y._ >= p.y;
				default:    return false;
		}
	}

}