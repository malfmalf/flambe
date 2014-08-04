package com.malfmalf.scenes;
import com.malfmalf.Button;
import com.malfmalf.TextButton;
import flambe.display.FillSprite;
import flambe.display.Sprite;
import flambe.display.Font;
import flambe.Entity;
import flambe.System;
import flambe.scene.Scene;
import flambe.scene.FadeTransition;
import flambe.animation.Ease;

/**
 * ...
 * @author ...
 */
class PauseScene{
	public static var sceneRoot(default, null):Entity;

	public static function createScene():Entity {
		//if (sceneRoot != null) sceneRoot.dispose();
		sceneRoot = new Entity();
		sceneRoot.add(new Scene());
		sceneRoot.addChild(new Entity().add(new FillSprite(0x808020,Constants.gameWidth, Constants.gameHeight ).centerAnchor().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5)));
		var resume_entity = new Entity();
		var restart_entity = new Entity();
		var levels_entity = new Entity();
		var resume_button = new Button(Main.buttons[9]);
		var restart_button = new Button(Main.buttons[13]);
		var levels_button = new Button(Main.buttons[12]);
		resume_entity.add(resume_button);
		restart_entity.add(restart_button);
		levels_entity.add(levels_button);
		sceneRoot.addChild(resume_entity);
		sceneRoot.addChild(restart_entity);
		sceneRoot.addChild(levels_entity);
		resume_entity.get(Sprite).centerAnchor().setXY(Constants.gameWidth * 0.3, Constants.gameHeight * 0.5);
		restart_entity.get(Sprite).centerAnchor().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5);
		levels_entity.get(Sprite).centerAnchor().setXY(Constants.gameWidth * 0.8, Constants.gameHeight * 0.5);
		resume_button.connectClicked(onResumeButton);
		restart_button.connectClicked(onRestartButton);
		levels_button.connectClicked(onLevelsButton);
		
		return sceneRoot;
	}
	
	public static function onResumeButton() {
		Main.director.popScene(new FadeTransition(1, Ease.quintInOut));
	}
	public static function onRestartButton() {
		Main.goGameScene(GameScene.level);
	}
	public static function onLevelsButton() {
		Main.goLevelsScene();
	}
}