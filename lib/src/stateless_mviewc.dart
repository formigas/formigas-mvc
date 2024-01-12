part of 'mvc.dart';

/// A [StatelessWidget] with [MVCBuilder] that rebuilds when the model from
/// [controller] changes.
abstract class MViewC<C extends MVController<M>, M> extends _MViewC {
  /// Base constructor for [MViewC].
  const MViewC({
    required this.controller,
    super.key,
  });

  /// The [MVController] which manages the model and provides business logic.
  final C controller;

  @override
  Widget _build(BuildContext context) => MVCBuilder<C, M>(
        controller: controller,
        builder: (context, _, model) => build(context, model),
      );

  /// Function will be called when he model from [controller] changes.
  @protected
  Widget build(BuildContext context, M model);
}
