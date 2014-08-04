package com.malfmalf;

import com.malfmalf.scenes.StartScene;
import com.malfmalf.scenes.GameScene;
import flambe.animation.Ease;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.math.Rectangle;
import flambe.scene.Director;
import flambe.scene.FadeTransition;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.math.Point;
import flambe.math.FMath;
import flambe.scene.SlideTransition;

class Main
{
	public static var directorEntity:Entity;
	public static var boardPack:AssetPack;
	public static var director:Director;
	
    private static function main (){
        // Wind up all platform-specific stuff
        System.init();
        var manifest = Manifest.fromAssets("board");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }

    private static function onSuccess (pack :AssetPack) {
		boardPack = pack;
        // Add a solid color background
        var background = new FillSprite(0x80ff80, System.stage.width, System.stage.height);
        System.root.addChild(new Entity().add(background));
		directorEntity = new Entity().add(new FillSprite(0x80ff8080, Constants.gameWidth, Constants.gameHeight));
		director = new Director();
		directorEntity.add(director);
		System.root.add(new Sprite());
		System.root.addChild(directorEntity);
		onResize();
		System.stage.resize.connect(onResize);
		System.keyboard.backButton.connect(onBackButton);
		director.pushScene(new Entity());
		director.setSize(Constants.gameWidth, Constants.gameHeight);
		goStartScene();
	}

	
	private static function onBackButton() {
		boardPack.getSound("back").play();
	}
	
	private static function onResize() {
			// iPhone 5 as target dimension
		var targetWidth = directorEntity.get(Sprite).getNaturalWidth(); 
		var targetHeight = directorEntity.get(Sprite).getNaturalHeight();

		// Specifies that the entire application be scaled for the specified target area while maintaining the original aspect ratio.
		var scale = FMath.min(System.stage.width / targetWidth, System.stage.height / targetHeight);
		if (scale > 1) scale = 1; // You could choose to never scale up.

		// re-scale and center the sprite of the container to the middle of the screen.
		directorEntity.get(Sprite)
			.centerAnchor()
			.setScale(scale)
			.setXY((System.stage.width ) / 2, (System.stage.height) / 2);

		// You can even mask so you cannot look outside of the container
		directorEntity.get(Sprite).scissor = new Rectangle(0, 0, targetWidth, targetHeight);
		
	}

	
	public static function goStartScene() : Entity {
		var ent = StartScene.createScene();
		var transition = new SlideTransition(1, Ease.quintInOut).left(); 
		director.pushScene(ent, transition); 	
		return ent;
	}
	public static function goGameScene() : Entity {
		var ent = GameScene.createScene();
		//var transition = new SlideTransition(1, Ease.quintInOut).right(); 
		var transition = new FadeTransition(1, Ease.quintInOut); 
		director.pushScene(ent, transition); 	
		return ent;		
	}
	

}
