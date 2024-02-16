import skyui.widgets.WidgetBase;

class PilferageBar extends WidgetBase
{
  private var _totalHp = NaN;

  public function PilferageBar()
  {
    super();
  }

  public function buildMeter(seg1, seg2, seg3, seg4, segSeal)
  {
    _totalHp = seg1 + seg2 + seg3 + seg4 + segSeal;
  }

  public function setPct(pct)
  {

  }

}
