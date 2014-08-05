package com.malfmalf;
import flambe.math.Point;
/**
 * ...
 * @author ...
 */
class PointUtils
{
	public static function manhattan(p1:Point, p2:Point):Float {
		return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y);
	}
	
}