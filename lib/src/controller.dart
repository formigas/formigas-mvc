part of 'mvc.dart';

/// MVController is a abstract class that is used to manage the state of the
/// model and update the screen when the model changes.
/// M is the type of the model.
abstract class MVController<M> {
  /// Creates a [MVController] with the given [initialModel].
  MVController(M initialModel)
      : _modelNotifier = ValueNotifier<M>(initialModel);

  final ValueNotifier<M> _modelNotifier;
  bool _isDisposed = false;

  /// current model state.
  M get model => _modelNotifier.value;

  /// updates the model and will update the screen.
  set model(M model) => _modelNotifier.value = model;

  /// Adds a listener to be called when the model changes.
  void _addListener(VoidCallback listener) =>
      _modelNotifier.addListener(listener);

  /// Removes a previously registered listener from the model.
  void _removeListener(VoidCallback listener) =>
      _modelNotifier.removeListener(listener);

  /// Called when this object is removed from the tree permanently.
  /// The framework calls this method when this [State] object will never
  /// build again. After the framework calls [dispose].
  @mustCallSuper
  void dispose() {
    if (!_isDisposed) {
      _modelNotifier.dispose();
      _isDisposed = true;
    }
  }
}
