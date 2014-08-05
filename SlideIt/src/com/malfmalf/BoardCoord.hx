package com.malfmalf;

/**
 * ...
 * @author ...
 */
class BoardCoord{
	public var i:Int;
	public var j:Int;
	public function new(i = -1, j = -1) {
		this.i = i;
		this.j = j;		
	}
	public function isValid():Bool {
		return i >= 0 && j >= 0;
	}
	public function left():BoardCoord {
		if (!isValid()) return new BoardCoord();
		return new BoardCoord(i - 1, j);
	}
	public function right():BoardCoord {
		if (!isValid()) return new BoardCoord();
		return new BoardCoord(i + 1, j);
	}
	public function up():BoardCoord {
		if (!isValid()) return new BoardCoord();
		return new BoardCoord(i , j - 1);
	}
	public function down():BoardCoord {
		if (!isValid()) return new BoardCoord();
		return new BoardCoord(i , j + 1);
	}
	public function eq(c:BoardCoord):Bool {
		return i == c.i && j == c.j;
	}
	public function toString():String {
		return "BoardCoord(" + i + "," + j + ")";
	}
}