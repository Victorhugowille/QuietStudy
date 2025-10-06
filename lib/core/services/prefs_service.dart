import 'package:quiet_study/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  late SharedPreferences _prefs;

  static final PrefsService _instance = PrefsService._internal();
  factory PrefsService() => _instance;
  PrefsService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool _getBool(String key) => _prefs.getBool(key) ?? false;
  Future<void> _setBool(String key, bool value) => _prefs.setBool(key, value);

  bool areBothPoliciesRead() {
    return _getBool(AppKeys.keyPrivacyPolicyAccepted) &&
        _getBool(AppKeys.keyTermsOfUseAccepted);
  }

  Future<void> setPolicyRead(String policyKey) async {
    await _setBool(policyKey, true);
  }

  bool isAllConsentAccepted() {
    return _prefs.getString(AppKeys.keyPoliciesVersionAccepted) == AppKeys.policyVersion;
  }

  Future<void> acceptAllPolicies() async {
    await _prefs.setString(AppKeys.keyPoliciesVersionAccepted, AppKeys.policyVersion);
    await _prefs.setString(AppKeys.keyAcceptedAt, DateTime.now().toIso8601String());
  }

  Future<void> revokeConsent() async {
    await _prefs.remove(AppKeys.keyPoliciesVersionAccepted);
    await _prefs.remove(AppKeys.keyAcceptedAt);
    await _prefs.remove(AppKeys.keyPrivacyPolicyAccepted);
    await _prefs.remove(AppKeys.keyTermsOfUseAccepted);
  }
}