import 'package:flutter/widgets.dart';

part 'model_listenable_builder.dart';

part 'controller.dart';

part 'mvc_builder.dart';

part 'stateless_mviewc.dart';

abstract class _MViewC extends Widget {
  const _MViewC({super.key});

  @protected
  Widget _build(BuildContext context);

  @override
  ComponentElement createElement() => _MViewCElement(this);
}

class _MViewCElement extends ComponentElement {
  _MViewCElement(_MViewC super.widget);

  @override
  Widget build() => (widget as _MViewC)._build(this);

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget, 'widget != newWidget');
    rebuild(force: true);
  }
}
