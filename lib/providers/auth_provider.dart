import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:taskflow_pms/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get isAuthenticated => FirebaseAuth.instance.currentUser != null;

  AuthProvider() {
    _user = _authService.currentUser;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final credential = await _authService.login(
        email: email,
        password: password,
      );

      _user = credential.user;

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          _error = 'Invalid email or password';
          break;

        default:
          _error = e.message ?? 'Login failed';
      }

      return false;
    } catch (e) {
      _error = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final credential = await _authService.signUp(
        email: email,
        password: password,
      );

      _user = credential.user;

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          _error = 'Email already in use';
          break;

        case 'weak-password':
          _error = 'Password is too weak';
          break;

        case 'invalid-email':
          _error = 'Invalid email';
          break;

        default:
          _error = e.message ?? 'Signup failed';
      }

      return false;
    } catch (e) {
      _error = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();

    _user = null;
    notifyListeners();
  }
}
