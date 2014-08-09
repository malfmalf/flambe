package com.malfmalf;

import com.malfmalf.blocks.MovingBlock;
import com.malfmalf.scenes.GameScene;
import flambe.asset.AssetPack;
import flambe.Component;
import flambe.Entity;
import flambe.display.Sprite;
import flambe.math.Point;
import com.malfmalf.tiles.Tile;
import com.malfmalf.tiles.*;
import com.malfmalf.blocks.Block;
import com.malfmalf.blocks.ColorBlock;
import com.malfmalf.blocks.Block.MoveDirection;

/**
 * ...
 * @author ...
 */
class Board extends Component {
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var definition(default, null):String;
	public var tiles(default, null):Array<Tile>;
	public var blocks(default, null):Array<Block>;
	public function new(def:String) {
		definition = def;
		tiles = new Array<Tile>();
		blocks = new Array<Block>();
	}
	public function reset(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		this.tiles = [for (i in 0...(width*height)) null];
		this.blocks = new Array<Block>();
	}

	override public function onAdded() {
		owner.add(new Sprite().setXY(Constants.gameWidth / 2, Constants.gameHeight / 2));
		var xml = Xml.parse(definition);
		Tiled.load(xml, new BoardLoader(this));
	}
	override public function onUpdate(dt:Float) {
		for (block in blocks) {
			if (Std.is(block, ColorBlock)) return;
		}
		Main.goFinishScene(true);
	}
	public function getTilePosition(c:BoardCoord):Point {
		var local = getLocalTilePosition(c);
		return new Point(owner.get(Sprite).x._ + local.x, owner.get(Sprite).y._ + local.y);
	}
	public function getLocalTilePosition(c:BoardCoord):Point {
		return new Point((c.i - (width - 1) * 0.5) * Constants.tileSize, (c.j - (height - 1) * 0.5 ) * Constants.tileSize);
	}
	public function getCoordFromPosition(p:Point, ?c:BoardCoord):BoardCoord {
		if (c == null) c = new BoardCoord();
		var res = new Point();
		owner.get(Sprite).getViewMatrix().inverseTransform(p.x, p.y, res);
		return getCoordFromLocalPosition(res);
	}
	public function getCoordFromLocalPosition(p:Point,?c:BoardCoord):BoardCoord {
		return getCoordFromLocalPositionXY(p.x,p.y,c);
	}
	public function getCoordFromLocalPositionXY(x:Float,y:Float,?c:BoardCoord):BoardCoord {
		if (c == null) c = new BoardCoord();
		c.i = Math.round(x / Constants.tileSize + (width  - 1) * 0.5);
		c.j = Math.round(y / Constants.tileSize + (height - 1) * 0.5);
		return c;
	}
	public function left() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.left();
		}
	}
	public function right() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.right();
		}
	}
	public function up() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.up();
		}
	}
	public function down() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.down();
		}
	}	
	public function isValid(c:BoardCoord):Bool {
		if (!c.isValid()) return false;
		return c.i < width && c.j < height;
	}
	public function getTile(c:BoardCoord):Tile {
		if (!isValid(c)) return null;
		return tiles[c.j * width + c.i];
	}
	public function getBlock(c:BoardCoord,?exclude:Block):Block{
		if (!isValid(c)) return null;
		for (b in blocks) {
			if (b == exclude) continue;
			if (b.coord.eq(c)) {
				return b;
			}
		}
		return null;
	}
	public function getBlocks(c:BoardCoord, ?exclude:Block):Array<Block> {
		var arr = new Array<Block>();
		if (!isValid(c)) return arr;
		for (b in blocks) {
			if (b == exclude) continue;
			if (b.coord.eq(c) || b.next_coord.eq(c)) {
				arr.push(b);
			}
		}
		return arr;
	}
	public function anyBlockMoving():Bool {
		for (b in blocks) {
			if (b.move!=MoveDirection.NONE) {
				return true;
			}
		}
		return false;
	}
}