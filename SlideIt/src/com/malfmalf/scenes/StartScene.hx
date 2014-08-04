package com.malfmalf.scenes;
import com.malfmalf.Button;
import flambe.display.FillSprite;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.System;
import flambe.scene.Scene;

/**
 * ...
 * @author ...
 */
class StartScene{
	public static var sceneRoot(default, null):Entity;
	public static var startButton:Button;

	public static function createScene():Entity {
		//if (sceneRoot != null) sceneRoot.dispose();
		sceneRoot = new Entity();
		sceneRoot.add(new Scene());
		sceneRoot.addChild(new Entity().add(new FillSprite(0x808080,Constants.gameWidth, Constants.gameHeight ).centerAnchor().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5)));
		var start_entity = new Entity();
		startButton = new Button(Main.boardPack.getTexture("img/tiles/r"), Main.boardPack.getTexture("img/tiles/l"), Main.boardPack.getTexture("img/tiles/u"));
		start_entity.add(startButton);
		start_entity.get(Sprite).centerAnchor().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5);
		sceneRoot.addChild(start_entity);
		startButton.connectClicked(onStartButton);
		
		return sceneRoot;
	}
	
	public static function onStartButton() {
			Main.goGameScene();
	}
}