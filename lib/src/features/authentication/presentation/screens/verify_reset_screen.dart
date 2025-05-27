import 'package:flutter/services.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/update_password_screen.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  final String? phone;
  const VerifyResetCodeScreen({super.key, this.phone});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  String _verificationCode = '';
  Timer? _resendTimer;
  int _remainingTime = 60;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes.last.requestFocus();
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _resendVerificationCode() async {
    if (_remainingTime == 0) {
      setState(() {
        _remainingTime = 60;
        _isVerifying = false;
      });
      _startTimer();
    }
  }

  String _formatTime() {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _handlePaste() async {
    try {
      final clipboardData = await Clipboard.getData('text/plain');
      if (clipboardData != null && clipboardData.text != null) {
        final pastedText = clipboardData.text!.trim();
        if (pastedText.length == 6 && RegExp(r'^\d+$').hasMatch(pastedText)) {
          for (int i = 0; i < 6; i++) {
            _controllers[i].text = pastedText[i];
            if (i < 5) {
              _focusNodes[i].requestFocus();
            }
          }
          _updateVerificationCode();
        }
      }
    } catch (e) {
      _showErrorSnackBar('فشل في لصق الكود: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: "استعادة كلمة المرور",
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightGrayColor
                  : AppColors.primaryColor),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          height: 140,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset("assets/images/logoWhit.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: _buildHeaderSection(),
        ),
        AppSizedBox.kVSpace20,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: _buildVerificationCodeInput(),
        ),
        _buildVerificationButtonSection(),
        AppSizedBox.kVSpace10,
        _buildTimerSection(),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomStyledText(
          text: "أدخل كود التحقق",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        AppSizedBox.kVSpace10,
        CustomStyledText(
          text: "تم إرسال كود التحقق إلى الواتساب الخاص بك",
          fontSize: 16,
          textColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildVerificationCodeInput() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) => _buildCodeDigitField(index))
                .reversed
                .toList(),
          ),
          AppSizedBox.kVSpace10,
          TextButton(
            onPressed: _handlePaste,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomStyledText(
                  text: "لصق رمز التحقق",
                  fontSize: 14,
                ),
                AppSizedBox.kWSpace10,
                Icon(Icons.paste, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeDigitField(int index) {
    return SizedBox(
      width: 45,
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) => _handleCodeInputChange(value, index),
      ),
    );
  }

  Widget _buildVerificationButtonSection() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.verificationStatus == VerificationStatus.failure) {
          _showErrorSnackBar(state.errorMessage ?? "كود التحقق غير صحيح");
          setState(() => _isVerifying = false);
        }

        if (state.verificationStatus == VerificationStatus.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ResetPasswordScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return _isVerifying
            ? CustomButton(
                text: "",
                onPressed: () {},
                child: const SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(),
                ),
              )
            : CustomButton(
                text: "تحقق",
                onPressed: _verifyCode,
              );
      },
    );
  }

  Widget _buildTimerSection() {
    return Column(
      children: [
        if (_remainingTime > 0)
          CustomStyledText(
            text: "يمكنك إعادة الإرسال بعد ${_formatTime()}",
            fontSize: 16,
            textColor: Colors.grey,
          ),
        if (_remainingTime == 0)
          TextButton(
            onPressed: _resendVerificationCode,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh, size: 20),
                AppSizedBox.kWSpace10,
                CustomStyledText(
                  text: "إعادة إرسال الكود",
                  fontSize: 16,
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _handleCodeInputChange(String value, int index) {
    if (value.length == 1 && index > 0) {
      _focusNodes[index - 1].requestFocus();
    } else if (value.isEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    _updateVerificationCode();
  }

  void _updateVerificationCode() {
    setState(() {
      _verificationCode = _controllers.map((c) => c.text).join();
    });
  }

  Future<void> _verifyCode() async {
    if (_verificationCode.length != 6) {
      _showErrorSnackBar("الرجاء إدخال الكود المكون من 6 أرقام");
      return;
    }

    setState(() => _isVerifying = true);

    print(_verificationCode);
    try {
      context.read<AuthCubit>().verifyResetCode(
            ResetVerifyResetCodeModel(
              phoneNumber: widget.phone!,
              code: _verificationCode,
            ),
          );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(),
        ),
      );
    } catch (e) {
      setState(() => _isVerifying = false);
      _showErrorSnackBar("حدث خطأ أثناء التحقق: ${e.toString()}");
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomStyledText(text: message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
