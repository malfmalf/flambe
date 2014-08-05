package com.malfmalf.scenes;
import com.malfmalf.Button;
import com.malfmalf.LevelButton;
import com.malfmalf.TextButton;
import flambe.display.FillSprite;
import flambe.display.Sprite;
import flambe.display.Font;
import flambe.Entity;
import flambe.System;
import flambe.scene.Scene;

/**
 * ...
 * @author ...
 */
class LevelsScene{
	public static var sceneRoot(default, null):Entity;
	public static var startButton:Button;

	public static function createScene():Entity {
		//if (sceneRoot != null) sceneRoot.dispose();
		sceneRoot = new Entity();
		sceneRoot.add(new Scene());
		sceneRoot.addChild(new Entity().add(new FillSprite(0x80f080,Constants.gameWidth, Constants.gameHeight ).centerAnchor().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5)));
		var levels_entity = new Entity().add(new Sprite().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5));
		sceneRoot.addChild(levels_entity);
		for (i in 0...5) {
			for (j in 0...5) {
				var level = j * 5 + i + 1;
				var lev_but = new LevelButton(level);
				levels_entity.addChild(new Entity().add(lev_but));
				lev_but.connectLevelSelect(onLevelSelected);
				lev_but.owner.get(Sprite).setXY((i - 2.5) * 100, (j - 2.5) * 100).setScale(1.2);
			}
		}
		
		return sceneRoot;
	}
	
	public static function onLevelSelected(level:Int) {
			Main.goGameScene(level);
	}
}