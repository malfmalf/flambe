package com.malfmalf;
import com.malfmalf.scenes.GameScene;
import com.malfmalf.tiles.*;
import com.malfmalf.blocks.*;
import com.malfmalf.blocks.Block.MoveDirection;
import flambe.Entity;
using StringTools;
/**
 * ...
 * @author malf
 */

class BoardLoader implements TiledLoader{
	var board:Board;
	var sizeSet = false;
	var layerName:String;
	public function new(board:Board) {
		this.board = board;
	}
	
	/* INTERFACE com.malfmalf.TiledLoader */
	
	public function onProperty(name:String, value:String) {
			switch(name.toLowerCase()) {
				case "minmoves":
					GameScene.minMoves = Std.parseInt(value);
				default:
					trace("WARNING Unsupported property : " + name+"=" + value);
			}
	}
	
	public function onStartLayer(name:String, width:Int, height:Int) {
		layerName = name;
		if (sizeSet) {
			if (width != board.width) trace("WARNING Conflicting width : " + width + "!=" + board.width);
			if (height != board.height) trace("WARNING Conflicting height : " + height + "!=" + board.height);
		}
		else {
			board.reset(width, height);
			sizeSet = true;
		}
	}
	
	public function onEndLayer() {
		layerName = null;
	}
	
	public function onTile(count:Int, gid:Int) {
		var i = count % board.width;
		var j = count / board.width;
		var coord = new BoardCoord(Math.floor(i), Math.floor(j));
		if (!board.isValid(coord)) {
			trace("WARNING : Bad coord at " + layerName+"(" + count + ")=" + i + "," + j);
		}
		switch(gid) {
			case 0,1: //nada
			case 2:
				addTile(count, new EmptyTile(coord, board.getLocalTilePosition(coord),gid));
			case 3:
				addTile(count, new StopTile(coord, board.getLocalTilePosition(coord),gid));
			case 5:
				addTile(count, new DirectionTile(MoveDirection.LEFT,coord, board.getLocalTilePosition(coord),gid));
			case 6:
				addTile(count, new DirectionTile(MoveDirection.RIGHT,coord, board.getLocalTilePosition(coord),gid));
			case 7:
				addTile(count, new DirectionTile(MoveDirection.UP,coord, board.getLocalTilePosition(coord),gid));
			case 8:
				addTile(count, new DirectionTile(MoveDirection.DOWN, coord, board.getLocalTilePosition(coord), gid));
			case 9,10,11:
				addTile(count, new ColorTile(gid - 8, coord, board.getLocalTilePosition(coord), gid));
			case 13, 14, 15:
				addBlock(count , new ColorBlock(gid - 12, coord, board.getLocalTilePosition(coord), gid));
			case 16:
				addBlock(count , new MovingBlock(coord, board.getLocalTilePosition(coord), gid));
			case 4,12:
				trace("WARNING : Unsupported gid at " + layerName+"(" + count + ")=" + gid);
			default:
				trace("WARNING : Unsupported gid at " + layerName+"(" + count + ")=" + gid);
		}
	}
	private function addTile(count:Int, tile:Tile) {
		if (layerName != "tiles") trace("WARNING tile not in 'tiles' layer at " + layerName+"(" + count + ")");
		board.owner.addChild(new Entity().add(tile));
		board.tiles[count] = tile;
	}
	private function addBlock(count:Int, block:Block) {
		if (layerName != "blocks") trace("WARNING block not in 'blocks' layer at " + layerName+"(" + count + ")");
		board.owner.addChild(new Entity().add(block));
		board.blocks.push(block);
	}
	
}