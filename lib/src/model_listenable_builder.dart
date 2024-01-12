part of 'mvc.dart';

/// Type definition of WidgetBuilder that rebuilds when the model
/// from [controller] changes.
typedef ModelWidgetBuilder<C extends MVController<T>, T> = Widget Function(
  BuildContext context,
  C controller,
  T value,
);

/// ValueListenable implementation to work with [MVController] directly.
class ModelListenableBuilder<C extends MVController<T>, T>
    extends StatefulWidget {
  /// Creates a widget that rebuilds when the [controller] changes.
  const ModelListenableBuilder({
    required this.controller,
    required this.builder,
    super.key,
  });

  /// The [MVController] which manages the model updates
  /// and provides business logic.
  final C controller;

  /// Function will be called when he model from [controller] changes.
  final ModelWidgetBuilder<C, T> builder;

  @override
  State<StatefulWidget> createState() => _ModelListenableBuilderState<C, T>();
}

class _ModelListenableBuilderState<C extends MVController<T>, T>
    extends State<ModelListenableBuilder<C, T>> {
  late T value;

  C get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    value = controller.model;
    controller._addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(ModelListenableBuilder<C, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._removeListener(_valueChanged);
      value = controller.model;
      oldWidget.controller._addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    controller
      .._removeListener(_valueChanged)
      ..dispose();
    super.dispose();
  }

  void _valueChanged() {
    setState(() => value = controller.model);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller, value);
  }
}
