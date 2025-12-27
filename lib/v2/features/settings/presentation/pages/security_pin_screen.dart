import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/services/storage_service.dart';

// Provider for PIN
final securityPinProvider = StateProvider<String?>((ref) => null);

class SecurityPINScreen extends ConsumerStatefulWidget {
  final bool isCreating;
  final VoidCallback? onSuccess;

  const SecurityPINScreen({
    super.key,
    this.isCreating = false,
    this.onSuccess,
  });

  @override
  ConsumerState<SecurityPINScreen> createState() => _SecurityPINScreenState();
}

class _SecurityPINScreenState extends ConsumerState<SecurityPINScreen> {
  String _pin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      final available = await _localAuth.canCheckBiometrics;
      setState(() => _biometricAvailable = available);
    } catch (e) {
      setState(() => _biometricAvailable = false);
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated && mounted) {
        widget.onSuccess?.call();
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Biometric authentication failed');
      }
    }
  }

  void _onNumberPressed(String number) {
    setState(() {
      if (_isConfirming) {
        if (_confirmPin.length < 4) {
          _confirmPin += number;
          if (_confirmPin.length == 4) {
            _verifyPIN();
          }
        }
      } else {
        if (_pin.length < 4) {
          _pin += number;
          if (_pin.length == 4 && widget.isCreating) {
            _isConfirming = true;
          } else if (_pin.length == 4 && !widget.isCreating) {
            _verifyPIN();
          }
        }
      }
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (_isConfirming) {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        }
      } else {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      }
    });
  }

  Future<void> _verifyPIN() async {
    if (widget.isCreating) {
      // Creating new PIN
      if (_pin == _confirmPin) {
        // Save PIN
        await StorageService.instance.saveSecurityPin(_pin);
        ref.read(securityPinProvider.notifier).state = _pin;

        if (mounted) {
          widget.onSuccess?.call();
          Navigator.pop(context, true);
          context.showSuccessSnackBar('Security PIN created successfully');
        }
      } else {
        setState(() {
          _confirmPin = '';
          _isConfirming = false;
          _pin = '';
        });
        if (mounted) {
          context.showErrorSnackBar('PINs do not match. Please try again.');
        }
      }
    } else {
      // Verifying existing PIN
      final savedPin = await StorageService.instance.getSecurityPin();
      if (_pin == savedPin) {
        if (mounted) {
          widget.onSuccess?.call();
          Navigator.pop(context, true);
        }
      } else {
        setState(() => _pin = '');
        if (mounted) {
          context.showErrorSnackBar('Incorrect PIN');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPin = _isConfirming ? _confirmPin : _pin;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreating ? 'Create Security PIN' : 'Enter PIN'),
      ),
      body: Column(
        children: [
          const Spacer(),

          // Title
          Text(
            _isConfirming
                ? 'Confirm your PIN'
                : widget.isCreating
                    ? 'Create a 4-digit PIN'
                    : 'Enter your PIN',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // PIN dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < currentPin.length
                      ? AppColors.primary
                      : Colors.grey[300],
                ),
              ).animate().scale(delay: Duration(milliseconds: index * 100));
            }),
          ),

          const Spacer(),

          // Number pad
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                _buildNumberRow(['1', '2', '3']),
                const SizedBox(height: AppSpacing.md),
                _buildNumberRow(['4', '5', '6']),
                const SizedBox(height: AppSpacing.md),
                _buildNumberRow(['7', '8', '9']),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _biometricAvailable && !widget.isCreating
                        ? _buildNumberButton(
                            Icons.fingerprint,
                            isIcon: true,
                            onPressed: _authenticateWithBiometrics,
                          )
                        : const SizedBox(width: 80),
                    _buildNumberButton('0'),
                    _buildNumberButton(
                      Icons.backspace_outlined,
                      isIcon: true,
                      onPressed: _onDeletePressed,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) => _buildNumberButton(number)).toList(),
    );
  }

  Widget _buildNumberButton(
    dynamic content, {
    bool isIcon = false,
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed ?? (isIcon ? null : () => _onNumberPressed(content)),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: isIcon
              ? Icon(content as IconData, size: 28, color: AppColors.primary)
              : Text(
                  content as String,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

// Extension to add PIN methods to StorageService
extension SecurityPinStorage on StorageService {
  Future<void> saveSecurityPin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('security_pin', pin);
  }

  Future<String?> getSecurityPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('security_pin');
  }

  Future<bool> hasSecurityPin() async {
    final pin = await getSecurityPin();
    return pin != null && pin.isNotEmpty;
  }

  Future<void> deleteSecurityPin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('security_pin');
  }
}
