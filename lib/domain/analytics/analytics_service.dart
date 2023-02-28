import 'package:app_meditation/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticService{
  final _analytics = FirebaseAnalytics.instanceFor(app: fbApp);

}