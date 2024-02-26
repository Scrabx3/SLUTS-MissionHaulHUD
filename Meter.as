import com.greensock.*;
import com.greensock.easing.*;

class Meter extends MovieClip
{
	/* STAGE */
	public var start:MovieClip;
	public var mid:MovieClip;
	public var end:MovieClip;

	public var div1:MovieClip;
	public var div2:MovieClip;
	public var div3:MovieClip;

	public var mask:MovieClip;
	public var fill:MovieClip;
	public var background:MovieClip;
	
	/* VARIABLES */
	private static var WIDTHPERCENT = 75 * 100;	// Ratio: {n} Health for 1% screen width?
	private static var START_RATIO = 0.2;				// How much of start is part of filling
	private static var END_RATIO = 0.38;

	private var _meterTimeline: TimelineLite;
	private var _meterwidth: Number;
	private var _meterDuration: Number;

	/* INIT */
	public function Meter()
	{
		super();
		var fill_start = start._width * START_RATIO;
		var meterstart = start._width - fill_start;
		fill._x = mask._x = background._x = meterstart;

		_meterTimeline = new TimelineLite({_paused:true});
		_meterDuration = 0.01;
	}

	public function onLoad()
	{
	}

	/* PUBLIC */
	public function arrangeObjects(seg1, seg2, seg3, hpBase, segSeal)
	{
		var myPct = mask._width / _meterwidth;

		var stage_width = Stage.visibleRect.width;
		var fill_start = start._width * START_RATIO;
		var fill_end = end._width * END_RATIO;

		var totalHp = hpBase + segSeal;
		_meterwidth = stage_width * (totalHp / WIDTHPERCENT);
		mid._width = _meterwidth - (fill_start + fill_end);
		end._x = mid._x + mid._width;

		var segmentwidth = stage_width * (hpBase / WIDTHPERCENT);
		var getX = function(seg) {
			var atpercental = seg / hpBase;
			var divoffset = segmentwidth * atpercental;
			var coordinates = {x: divoffset, y: 0};
			start.localToGlobal(coordinates);
			globalToLocal(coordinates);
			return coordinates.x + (start._width - fill_start);
		};
		div1._x = getX(hpBase - seg1);
		div2._x = getX(hpBase - seg2);
		div3._x = getX(hpBase - seg3);

		var a = fill.fill_A;
		var b = fill.fill_B;
		var divcoords = {x: div1._x, y:div1._y};
		localToGlobal(divcoords);
		fill.globalToLocal(divcoords);
		a._width = divcoords.x - a._x;
		b._width = _meterwidth - segmentwidth;
		b._x = a._x + a._width;

		background._width = fill._width;
		setMeterPercent(myPct);
	}	

	public function setMeterPercent(percent)
	{
		_meterTimeline.clear();
		percent = Math.min(1, Math.max(percent, 0));
		mask._width = _meterwidth * percent;
	}

	public function updateMeterPercent(percent)
	{
		percent = Math.min(1, Math.max(percent, 0));

		if (!_meterTimeline.isActive())
		{
			_meterTimeline.clear();
			_meterTimeline.progress(0);
			_meterTimeline.restart();
		}
		_meterTimeline.to(mask, 1, {_width: _meterwidth * percent}, _meterTimeline.time() + _meterDuration);
		_meterTimeline.play();
	}

}