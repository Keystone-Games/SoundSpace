package io.github.keystone_games.soundspace.util.map;

import haxe.Json;
#if sys
import sys.io.File;
#end

class MapDB {
	// public static final Level1 = {
	// 	name: "Sinefeld",
	// 	bpm: 127,
	// 	difficulty: "Easy",
	// 	dm: 1,
	// 	artist: "SidGames",
	// 	mapper: "SidGames"
	// };
	public static function Level1():Map {
		#if sys
		var content = File.getContent("resources/data/1_sinefeld.json");
		var x:Map = Json.parse(content);
		return x;
		#else
		return null;
		#end
	}
}

typedef Map = {
	var info:{
		name:String,
		bpm:Float,
		difficulty:String,
		dm:Int,
		artist:String,
		mapper:String
	}
	var level:{
		sound:{start:Int},
		chart:Array<{time:Int}>
	}
}
