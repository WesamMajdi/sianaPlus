import 'package:flutter/services.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';

class Verification2Screen extends StatefulWidget {
  final String? phone;
  final String? selectedCountryCode;

  const Verification2Screen({
    super.key,
    this.phone,
    this.selectedCountryCode,
  });

  @override
  State<Verification2Screen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<Verification2Screen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  String _verificationCode = '';
  Timer? _resendTimer;
  int _remainingTime = 60;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
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
        setState(() => _remainingTime--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _resendVerificationCode() async {
    if (_remainingTime == 0 && !_isResending) {
      setState(() => _isResending = true);

      try {
        final fullPhoneNumber = '${widget.phone} ${widget.selectedCountryCode}';
        context.read<AuthCubit>().sendVerificationCode2(
              fullPhoneNumber,
              _verificationCode,
            );

        setState(() {
          _remainingTime = 60;
          _isResending = false;
        });
        _startTimer();
        showTopSnackBar(
            context, "تم إعادة إرسال كود التحقق بنجاح", Colors.green);
      } catch (e) {
        setState(() => _isResending = false);
        showTopSnackBar(
            context, "فشل في إعادة الإرسال: ${e.toString()}", Colors.redAccent);
      }
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
          for (var controller in _controllers) {
            controller.clear();
          }
          for (int i = 0; i < 6; i++) {
            _controllers[i].text = pastedText[i];
          }
          _focusNodes[5].requestFocus();
          _updateVerificationCode();
        } else {
          showTopSnackBar(context, "يجب أن يكون رمز التحقق مكون من 6 أرقام فقط",
              Colors.redAccent);
        }
      }
    } catch (e) {
      showTopSnackBar(
          context, 'فشل في لصق الرمز: ${e.toString()}', Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: "التحقق من الحساب",
        onBackTap: () => Navigator.pop(context),
      ),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(),
          AppSizedBox.kVSpace20,
          _buildVerificationCodeInput(),
          AppSizedBox.kVSpace20,
          _buildVerificationButtonSection(),
          AppSizedBox.kVSpace10,
          _buildTimerSection(),
        ],
      ),
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
            children: List.generate(6, (index) => _buildCodeDigitField(index)),
          ),
          AppSizedBox.kVSpace10,
          TextButton(
            onPressed: _handlePaste,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomStyledText(
                  text: "لصق رمز التحقق",
                  fontSize: 16,
                ),
                AppSizedBox.kWSpace10,
                Icon(Icons.paste, size: 20),
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
          onChanged: (value) => _handleCodeInputChange(value, index),
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
    );
  }

  Widget _buildVerificationButtonSection() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.sendVerificationCode2Status ==
            SendVerificationCode2Status.success) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SuccessPage(
                  message: state.successMessage ?? "تم التحقق بنجاح",
                ),
              ),
              (route) => false,
            );
          });
        }
      },
      builder: (context, state) {
        if (state.sendVerificationCode2Status ==
            SendVerificationCode2Status.loading) {
          return CustomButton(
            text: "",
            onPressed: () {},
            child: const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        }

        return CustomButton(
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
          _isResending
              ? const CircularProgressIndicator()
              : TextButton(
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
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    _updateVerificationCode();
  }

  void _updateVerificationCode() {
    setState(() => _verificationCode = _controllers.map((c) => c.text).join());
  }

  Future<void> _verifyCode() async {
    if (_verificationCode.length != 6) {
      showTopSnackBar(
          context, "الرجاء إدخال الكود المكون من 6 أرقام", Colors.redAccent);
      return;
    }

    try {
      final fullPhoneNumber = '${widget.phone} ${widget.selectedCountryCode}';
      await context.read<AuthCubit>().sendVerificationCode2(
            fullPhoneNumber,
            _verificationCode,
          );
    } catch (e) {
      showTopSnackBar(
          context, "حدث خطأ أثناء التحقق: ${e.toString()}", Colors.redAccent);
    }
  }
}
