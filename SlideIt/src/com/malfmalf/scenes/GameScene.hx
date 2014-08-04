package com.malfmalf.scenes;
import com.malfmalf.Button;
import flambe.display.Sprite;
import flambe.display.FillSprite;
import flambe.Entity;
import flambe.System;
import flambe.scene.Scene;
import flambe.input.Key;
import flambe.input.KeyboardEvent;
import flambe.input.MouseEvent;
import flambe.input.PointerEvent;
import flambe.math.Point;

/**
 * ...
 * @author ...
 */
class GameScene{
	public static var sceneRoot(default, null):Entity;
	public static var board:Board;
	public static var level:Int;

	private static var mouseDownPos:Point;

	public static function createScene(level:Int):Entity {
//		if (sceneRoot != null) sceneRoot.dispose();
		GameScene.level = level;
		sceneRoot = new Entity();
		sceneRoot.add(new Scene());
		sceneRoot.addChild(new Entity().add(new FillSprite(0x808080,Constants.gameWidth, Constants.gameHeight ).centerAnchor().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5)));
		createBoard();
		var but_ent = new Entity();
		var but = new Button(Main.buttons[8]);
		but_ent.add(but);
		sceneRoot.addChild(but_ent);
		but_ent.get(Sprite).setXY(Constants.gameWidth - 64, 0);
		but.connectClicked(onPause);
		System.keyboard.down.connect(keyDown);
		System.pointer.down.connect(mouseDown);
		System.pointer.up.connect(mouseUp);
		return sceneRoot;
	}
	private static function onPause() {
		Main.goPauseScene();
	}
	private static function createBoard() {
		var boardRoot = new Entity();
		board = new Board(Main.boardPack.getFile("levels/"+level+".txt").toString());
		boardRoot.add(board);
		sceneRoot.addChild(boardRoot);
	}
	
	private static function keyDown(e:KeyboardEvent) {
		if (e.key == Key.Left)  board.left();
		if (e.key == Key.Right) board.right();
		if (e.key == Key.Up)    board.up();
		if (e.key == Key.Down)  board.down();
	}
	private static function mouseDown(e:PointerEvent) {
		mouseDownPos = new Point(e.viewX, e.viewY);
	}
	private static function mouseUp(e:PointerEvent) {
		if (mouseDownPos == null) return;
		var dx = mouseDownPos.x - e.viewX;
		var dy = mouseDownPos.y - e.viewY;
		if (Math.abs(dx) > Math.abs(dy)) {
			if (dx > 100) {
				board.left();
			}	
			if (dx < -100) {
				board.right();
			}
		}
		else {
			if (dy > 100) {
				board.up();
			}	
			if (dy < -100) {
				board.down();
			}
		}
	}	
}