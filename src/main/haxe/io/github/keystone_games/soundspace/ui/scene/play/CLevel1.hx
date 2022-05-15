package io.github.keystone_games.soundspace.ui.scene.play;

import io.github.keystone_games.kglog.Logger;
import haxe.Timer;
import io.github.keystone_games.soundspace.util.map.MapDB;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;

class CLevel1 extends FlxState {
	public static var levelIndicator:FlxText;
	public static var difficultyIndicator:FlxText;

	public static var time:Float = 0;
	public static var tempTime:Float = 0;
	public static var beats:Int = 0;
	public static var bpm:Float = MapDB.Level1().info.bpm;
	public static var diff:Float = MapDB.Level1().info.dm;
	public static var score:Int = 0;

	public static var start:Bool = false;
	public static var activate:Bool = false;
	public static var musicInit:Bool = false;
	public static var temp1:Bool = false;

	public static var lane1:FlxSprite;
	public static var lane2:FlxSprite;
	public static var lane3:FlxSprite;
	public static var lane4:FlxSprite;

	public static var note1:FlxSprite;
	public static var note2:FlxSprite;
	public static var note3:FlxSprite;
	public static var note4:FlxSprite;
	public static var note5:FlxSprite;
	public static var note6:FlxSprite;
	public static var note7:FlxSprite;
	public static var note8:FlxSprite;
	public static var note9:FlxSprite;
	public static var note10:FlxSprite;

	public static var note1enabled:Bool = false;
	public static var note2enabled:Bool = false;
	public static var note3enabled:Bool = false;
	public static var note4enabled:Bool = false;
	public static var note5enabled:Bool = false;
	public static var note6enabled:Bool = false;
	public static var note7enabled:Bool = false;
	public static var note8enabled:Bool = false;
	public static var note9enabled:Bool = false;
	public static var note10enabled:Bool = false;

	public static var key1:FlxSprite;
	public static var key2:FlxSprite;
	public static var key3:FlxSprite;
	public static var key4:FlxSprite;

	public override function create() {
		super.create();

		FlxG.mouse.visible = false;

		FlxG.updateFramerate = 1000;
		FlxG.drawFramerate = 1000;

		levelIndicator = new FlxText(0, 0, 0, "Level 1").setFormat("resources/assets/fonts/monsterrat.ttf", 32, FlxColor.WHITE, CENTER);
		levelIndicator.screenCenter(X);
		add(levelIndicator);

		difficultyIndicator = new FlxText(0, 0, 0,
			"Difficulty: " + MapDB.Level1().info.difficulty).setFormat("resources/assets/fonts/monsterrat.ttf", 128, FlxColor.fromString("#ff3f48cc"), CENTER);
		difficultyIndicator.screenCenter(XY);

		lane1 = new FlxSprite();
		lane1.makeGraphic(Std.int(FlxG.width / 8), Std.int((FlxG.height / 16) * 12), FlxColor.fromString("#7f3e3e3e"));
		lane1.screenCenter(X);
		lane1.y = Std.int(FlxG.height / 16);
		lane1.x -= Std.int(lane1.width) * 2 - Std.int(lane1.width) * 0.5;
		add(lane1);
		lane2 = new FlxSprite();
		lane2.makeGraphic(Std.int(FlxG.width / 8), Std.int((FlxG.height / 16) * 12), FlxColor.fromString("#7f3e3e3e"));
		lane2.screenCenter(X);
		lane2.y = Std.int(FlxG.height / 16);
		lane2.x -= Std.int(lane2.width) * 1 - Std.int(lane2.width) * 0.5;
		add(lane2);
		lane3 = new FlxSprite();
		lane3.makeGraphic(Std.int(FlxG.width / 8), Std.int((FlxG.height / 16) * 12), FlxColor.fromString("#7f3e3e3e"));
		lane3.screenCenter(X);
		lane3.y = Std.int(FlxG.height / 16);
		lane3.x += Std.int(lane3.width) * 1 - Std.int(lane3.width) * 0.5;
		add(lane3);
		lane4 = new FlxSprite();
		lane4.makeGraphic(Std.int(FlxG.width / 8), Std.int((FlxG.height / 16) * 12), FlxColor.fromString("#7f3e3e3e"));
		lane4.screenCenter(X);
		lane4.y = Std.int(FlxG.height / 16);
		lane4.x += Std.int(lane4.width) * 2 - Std.int(lane4.width) * 0.5;
		add(lane4);
		trace(Std.int(FlxG.height / 16) * 4);

		note1 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note2 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note3 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note4 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note5 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note6 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note7 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note8 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note9 = new FlxSprite(0, 0, Assets.ClassicNote__png);
		note10 = new FlxSprite(0, 0, Assets.ClassicNote__png);

		key1 = new FlxSprite(0, 0, Assets.Key__png);
		key1.x = lane1.x;
		key1.y = lane1.y;
		key1.y += lane1.height;
		add(key1);
		key2 = new FlxSprite(0, 0, Assets.Key__png);
		key2.x = lane2.x;
		key2.y = lane2.y;
		key2.y += lane2.height;
		add(key2);
		key3 = new FlxSprite(0, 0, Assets.Key__png);
		key3.x = lane3.x;
		key3.y = lane3.y;
		key3.y += lane3.height;
		add(key3);
		key4 = new FlxSprite(0, 0, Assets.Key__png);
		key4.x = lane4.x;
		key4.y = lane4.y;
		key4.y += lane4.height;
		add(key4);

		add(difficultyIndicator);

		Timer.delay(function() {
			remove(difficultyIndicator);
			start = true;
			activate = true;
		}, 2500);

		// note initializations
		note1.x = lane2.x;
		note1.y = lane2.y;
	}

	public override function update(dt:Float) {
		super.update(dt);

		if (activate) {
			activate = false;
			add(note1);
			note1enabled = true;
		}

		if (start) {
			note1.y += diff * 6;
			// Timer.delay(function() {}, Math.round(1 / 254));
		}

		if (note1.overlaps(key2) && !temp1) {
			musicInit = true;
		}

		if (time == (1000 / 254) - diff * 6) {
			note2.x = lane1.x;
			note2.y = lane1.y;
			add(note2);
			note2enabled = true;
		}

		if (note1enabled) {
			note1.y += diff * 6;
		}
		if (note2enabled) {
			note2.y += diff * 6;
		}
		if (note3enabled) {
			note3.y += diff * 6;
		}
		if (note4enabled) {
			note4.y += diff * 6;
		}
		if (note5enabled) {
			note5.y += diff * 6;
		}
		if (note6enabled) {
			note6.y += diff * 6;
		}
		if (note7enabled) {
			note7.y += diff * 6;
		}
		if (note8enabled) {
			note8.y += diff * 6;
		}
		if (note9enabled) {
			note9.y += diff * 6;
		}
		if (note10enabled) {
			note10.y += diff * 6;
		}

		if (musicInit) {
			musicInit = false;
			#if html5
			FlxG.sound.playMusic(Data.Sinefeld__mp3, Reference.VOLUME_MULTIPLIER, false);
			#else
			FlxG.sound.playMusic(Data.Sinefeld__ogg, Reference.VOLUME_MULTIPLIER, false);
			#end
			beats = 0;
			Logger.debug("Music started");
			temp1 = true;
		}

		if (FlxG.keys.pressed.D) {
			key1.loadGraphic(Assets.KeyPressed__png);
			if (note1.overlaps(key1)) {
				remove(note1);
				score += 1;

				// FlxG.sound.play(Data.Hit__wav, Reference.VOLUME_MULTIPLIER);
			}
			note1enabled = false;
		} else {
			key1.loadGraphic(Assets.Key__png);
			note1enabled = false;
		}
		if (FlxG.keys.pressed.F) {
			key2.loadGraphic(Assets.KeyPressed__png);
			if (note1.overlaps(key2)) {
				remove(note1);
				score += 1;
				// FlxG.sound.play(Data.Hit__wav, Reference.VOLUME_MULTIPLIER);
			}
			note1enabled = false;
		} else {
			key2.loadGraphic(Assets.Key__png);
			note1enabled = false;
		}
		if (FlxG.keys.pressed.J) {
			key3.loadGraphic(Assets.KeyPressed__png);
			if (note1.overlaps(key3)) {
				remove(note1);
				score += 1;
				// FlxG.sound.play(Data.Hit__wav, Reference.VOLUME_MULTIPLIER);
			}
			note1enabled = false;
		} else {
			key3.loadGraphic(Assets.Key__png);
			note1enabled = false;
		}
		if (FlxG.keys.pressed.K) {
			key4.loadGraphic(Assets.KeyPressed__png);
			if (note1.overlaps(key4)) {
				remove(note1);
				score += 1;
				// FlxG.sound.play(Data.Hit__wav, Reference.VOLUME_MULTIPLIER);
			}
			note1enabled = false;
		} else {
			key4.loadGraphic(Assets.Key__png);
			note1enabled = false;
		}

		time += dt;
		tempTime += dt;
		if (tempTime > Math.round((1 / (bpm / 60)))) {
			tempTime = 0;
			beats++;
		}
		Logger.debug("Beats: " + beats);
		Logger.debug("Time: " + time);
	}
}
