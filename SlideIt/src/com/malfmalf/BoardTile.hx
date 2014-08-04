package com.malfmalf;
import flambe.Component;
import flambe.math.Point;

/**
 * ...
 * @author ...
 */
class BoardTile extends Component{
	public var coord(default, null):BoardCoord;
	public var pos(default, null):Point;
	public function new(c:BoardCoord,p:Point){
		coord = c;
		pos = p;
	}
	override public function onAdded() {
		trace("Non specific BoardTile added....");
	}
	public function onEnterStart(block:Block) {
		
	}
	public function onEnterEnd(block:Block) {
		
	}
	
}