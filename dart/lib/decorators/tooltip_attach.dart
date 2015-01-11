library tooltip_attach;

import 'package:angular/angular.dart' show NgAttr, Decorator;
import 'package:angular/angular.dart' as ng;
import 'dart:html' as dom;

@Decorator(
  selector: '[tooltip-attach]'
)
class TooltipAttachDec {
  var element;
  var state;

  @NgAttr('tooltip-attach')
  var tooltipAttach;

  get tooltip {
    var tooltip;
    var selector = this.tooltipAttach;

    if (selector != '' && selector != null) {
      tooltip = this.element.parent.querySelector(selector);
    }
    else {
      tooltip = this.element.previousElementSibling;
    }

    return ng.ngDirectives(tooltip)[0];
  }

  show() {
    if (this.state == true) {
      return;
    }
    this.state = true;

    var x = this.element.offsetLeft;
    var y = this.element.offsetTop;
    var width = this.element.offsetWidth;
    var height = this.element.offsetHeight;

    this.tooltip.show(x + (width / 2), y - height  - 10);
  }

  hide() {
    if (this.state != true) {
      return;
    }
    this.state = false;
    this.tooltip.hide();
  }

  TooltipAttachDec(dom.Element this.element) {
    this.element
      ..onMouseEnter.listen((_) {
        this.show();
      })
      ..onMouseOver.listen((_) {
        this.show();
      })
      ..onMouseLeave.listen((_) {
        this.hide();
      });
  }
}