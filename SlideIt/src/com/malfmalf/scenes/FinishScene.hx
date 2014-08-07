package com.malfmalf.scenes;
import com.malfmalf.Button;
import flambe.display.FillSprite;
import flambe.display.Font;
import flambe.display.Sprite;
import flambe.display.TextSprite;
import flambe.Entity;
import flambe.scene.Scene;

/**
 * ...
 * @author ...
 */
class FinishScene{
	public static var sceneRoot(default, null):Entity;
	public static function createScene(win:Bool):Entity {
		//if (sceneRoot != null) sceneRoot.dispose();
		sceneRoot = new Entity();
		sceneRoot.add(new Scene(false));
		sceneRoot.addChild(new Entity().add(new FillSprite(0x808020,Constants.gameWidth, Constants.gameHeight ).centerAnchor().setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5).setAlpha(0.5)));
		var restart_entity = new Entity();
		var levels_entity = new Entity();
		var restart_button = new Button(Main.buttons.getCut("but_restart"));
		var levels_button = new Button(Main.buttons.getCut("but_levels"));
		restart_entity.add(restart_button);
		levels_entity.add(levels_button);
		sceneRoot.addChild(restart_entity);
		sceneRoot.addChild(levels_entity);
		restart_entity.get(Sprite).centerAnchor().setXY(Constants.gameWidth * 0.33, Constants.gameHeight * 0.5);
		levels_entity.get(Sprite).centerAnchor().setXY(Constants.gameWidth * 0.66, Constants.gameHeight * 0.5) ;
		restart_button.connectClicked(onRestartButton);
		levels_button.connectClicked(onLevelsButton);
		var font = new Font(Main.boardPack, "fonts/timotheos");
		if(win){
			var next_entity = new Entity();
			var next_button = new Button(Main.buttons.getCut("but_next"));
			next_entity.add(next_button);
			sceneRoot.addChild(next_entity);
			next_button.connectClicked(onNextButton);
			next_entity.get(Sprite).centerAnchor().setXY(Constants.gameWidth * 0.25, Constants.gameHeight * 0.5);
			restart_entity.get(Sprite).setXY(Constants.gameWidth * 0.5, Constants.gameHeight * 0.5);
			levels_entity.get(Sprite).setXY(Constants.gameWidth * 0.75, Constants.gameHeight * 0.5);
			sceneRoot.addChild(new Entity().add(new TextSprite(font, "Moves : " + GameScene.moves).centerAnchor().setXY(Constants.gameWidth * 0.5, 100)));
			sceneRoot.addChild(new Entity().add(new TextSprite(font, "Min Moves : " + GameScene.minMoves).centerAnchor().setXY(Constants.gameWidth * 0.5, 150)));
		}
		else {
			sceneRoot.addChild(new Entity().add(new TextSprite(font, "FAILED!!").centerAnchor().setXY(Constants.gameWidth * 0.5, 100)));
		}
		return sceneRoot;
	}
	
	public static function onNextButton() {
		Main.goGameScene(GameScene.level+1);
	}
	public static function onRestartButton() {
		Main.goGameScene(GameScene.level);
	}
	public static function onLevelsButton() {
		Main.goLevelsScene();
	}
}