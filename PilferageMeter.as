import skyui.widgets.WidgetBase;
import gfx.utils.Delegate;
import com.greensock.*;
import com.greensock.easing.*;


class PilferageMeter extends WidgetBase
{
	/* STAGE */
	public var meter:Meter;
	public var crate:MovieClip;

	/* INIT */
	public function PilferageMeter()
	{
		super();

		_global.gfxExtensions = true;
	}

	public function onLoad()
	{
	}

	private var _tHP = 1000;
	private var _testID: Number;
	private function test()
	{
		trace("Tick...")
		switch (_tHP) {
			case 1000:
				buildMeter(0, 150, 600, _tHP, 500);
				break;
			case 1200:
				setPct(75);
				break;
			case 1400:
				setPct(50);
				break;
			case 1600:
				setPct(25);
				break;
			case 1800:
				setPct(0);
				break;
			case 2000:
				clearInterval(_testID);
				break;
		}
	}

	/* PAPYRUS */
	public function buildMeter(seg1, seg2, seg3, hpTotal, segSeal)
	{
		meter.arrangeObjects(seg1, seg2, seg3, hpTotal, segSeal);
	}

	public function setPct(pct)
	{
		if (pct > 1)
			pct /= 100;

		if (_alpha < 100)
			show()

		meter.updateMeterPercent(pct);
	}

	public function setLocation(xpos_prc: Number, ypos_prc: Number, rot: Number, scale: Number)
	{
		// var minXY: Object = {x: Stage.visibleRect.x + Stage.safeRect.x, y: Stage.visibleRect.y + Stage.safeRect.y};
		var maxXY: Object = {x: Stage.visibleRect.x + Stage.visibleRect.width - Stage.safeRect.x, y: Stage.visibleRect.y + Stage.visibleRect.height - Stage.safeRect.y};

		//  (minXY.x, minXY.y) _____________ (maxXY.x, minXY.y)
		//                    |             |
		//                    |     THE     |
		//                    |    STAGE    |
		//  (minXY.x, maxXY.y)|_____________|(maxXY.x, maxXY.y)

		this._x = maxXY.x * xpos_prc;
		this._y = maxXY.y * ypos_prc;

		if (rot != undefined)
			this._rotation = rot;
		if (scale != undefined)
			this._xscale = this._yscale = scale;
	}

	public function toggleVisibility()
	{
		if (_alpha)
			_alpha = 0
		else
			_alpha = 100
	}

	public function show(dur)
	{
		if (dur == undefined)
			dur = 0.6

		TweenLite.to(this, dur, { _alpha: 100, ease: Strong.easeIn });
	}

	public function hide(force)
	{
		if (force) {
			_alpha = 0;
			return;
		}
		TweenLite.to(this, 0.9, { _alpha: 0, ease: Quint.easeOut });
	}

}