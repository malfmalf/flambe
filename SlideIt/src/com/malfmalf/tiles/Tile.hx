package com.malfmalf.tiles ;
import flambe.Component;
import flambe.math.Point;
import com.malfmalf.blocks.Block;
/**
 * ...
 * @author ...
 */
class Tile extends Component{
	public var coord(default, null):BoardCoord;
	public var pos(default, null):Point;
	public var textureId(default, null):Int;
	public function new(c:BoardCoord,p:Point,textureId:Int){
		coord = c;
		pos = p;
		this.textureId = textureId;
	}
	override public function onAdded() {
		trace("Non specific BoardTile added....");
	}
	public function onEnterStart(block:Block) {
	}
	public function onEnterEnd(block:Block) {
	}
	
	public function toString():String {
		return get_name() + " @ " + coord;
	}	
}