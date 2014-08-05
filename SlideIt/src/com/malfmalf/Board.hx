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
	public var tileRoot(default, null):Entity;
	public var blockRoot(default, null):Entity;
	public function new(def:String) {
		definition = def;
		tiles = new Array<Tile>();
		blocks = new Array<Block>();
	}
	private function addTile(c:BoardCoord, t:String) {
		var e = new Entity();
		var tile:Tile = null;
		if (t == "_") {
			tile = new EmptyTile(c, getLocalTilePosition(c));
		}
		else if (t == "X") {
			tile = new StopTile(c, getLocalTilePosition(c));
		}
		else if (t == "L") {
			tile = new DirectionTile(MoveDirection.LEFT,c, getLocalTilePosition(c));
		}
		else if (t == "R") {
			tile = new DirectionTile(MoveDirection.RIGHT,c, getLocalTilePosition(c));
		}
		else if (t == "U") {
			tile = new DirectionTile(MoveDirection.UP,c, getLocalTilePosition(c));
		}
		else if (t == "D") {
			tile = new DirectionTile(MoveDirection.DOWN,c, getLocalTilePosition(c));
		}
		else  {
			tile = new ColorTile(Std.parseInt(t),c, getLocalTilePosition(c));
		}
		e.add(tile);
		tileRoot.addChild(e);
		tiles.push(tile);
	}
	private function addBlock(c:BoardCoord, t:String) {
		if (t == "0") {
		}
		else if (t == "M") {
			var e = new Entity();
			var block = new MovingBlock(c, getLocalTilePosition(c));
			e.add(block);
			blockRoot.addChild(e);
			blocks.push(block);		
		}
		else  {
			var e = new Entity();
			var block = new ColorBlock(Std.parseInt(t),c, getLocalTilePosition(c));
			e.add(block);
			blockRoot.addChild(e);
			blocks.push(block);		
		}
	}
	override public function onAdded() {
		owner.add(new Sprite().setXY(Constants.gameWidth / 2, Constants.gameHeight / 2));
		tileRoot = new Entity();
		blockRoot = new Entity();
		tileRoot.add(new Sprite());
		blockRoot.add(new Sprite());
		owner.addChild(tileRoot);
		owner.addChild(blockRoot);
		var lines = definition.split("\n");
		var dims = lines[0].split(",");
		width = Std.parseInt(dims[0]);
		height = Std.parseInt(dims[1]);
		for (j in 0...height) {
			for (i in 0...width) {
				var c = new BoardCoord(i, j);
				addTile(c, lines[j + 1].charAt(i));
				addBlock(c, lines[j + 9].charAt(i));
			}
		}
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
		return new Point((c.i - width * 0.5) * 64, (c.j - height * 0.5) * 64);
	}
	public function left() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.move = MoveDirection.LEFT;
		}
	}
	public function right() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.move = MoveDirection.RIGHT;
		}
	}
	public function up() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.move = MoveDirection.UP;
		}
	}
	public function down() {
		if (anyBlockMoving()) return;
		++GameScene.moves;
		for (b in blocks) {
			b.move = MoveDirection.DOWN;
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
	public function getBlock(c:BoardCoord):Block{
		if (!isValid(c)) return null;
		for (b in blocks) {
			if (b.coord.eq(c)) {
				return b;
			}
		}
		return null;
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