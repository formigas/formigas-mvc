abstract interface class MvcController implements ControllerAnalytics {}

abstract interface class ControllerAnalytics {
  void trackPageView({required final String pageName}) {}
}
