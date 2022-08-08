import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../core/constant/locale_keys.dart';
import '../../../core/style/color.dart';
import '../../../core/style/dimension.dart';
import '../../../core/style/textstyle.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/form_input/primary_text_field.dart';
import '../../../widgets/ui_helper.dart';

enum VerificationStep {
  sendCode,
  verify,
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with SuraFormMixin, CountdownMixin {
  late TextEditingController emailTC, codeTC;
  VerificationStep step = VerificationStep.sendCode;

  Future<void> onSendVerificationCode() async {
    if (isFormValidated) {
      try {
        String email = emailTC.text.trim();
        await Future.delayed(const Duration(seconds: 2));
        startCountDownTimer();
        setState(() {
          step = VerificationStep.verify;
        });
        startCountDownTimer();
      } catch (e) {
        UIHelper.showErrorDialog(context, e);
      }
    }
  }

  @override
  Future<void> resendCode() async {
    startCountDownTimer();
  }

  Future<void> onVerifyCode(String code) async {}

  @override
  void initState() {
    codeTC = TextEditingController();
    emailTC = TextEditingController(text: "email");
    super.initState();
  }

  @override
  void dispose() {
    codeTC.dispose();
    emailTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: ""),
      body: SingleChildScrollView(
        padding: AppDimension.pageSpacing,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr(LocaleKeys.reset_password), style: kHeaderStyle),
              const SpaceY(24),
              PrimaryTextField(
                controller: emailTC,
                hint: tr(LocaleKeys.email),
                readOnly: step == VerificationStep.verify,
              ),
              if (step == VerificationStep.sendCode) ...[
                PrimaryButton(
                  onPressed: onSendVerificationCode,
                  child: Text(LocaleKeys.send_verification_code.tr()),
                ),
              ] else ...[
                Text(LocaleKeys.we_have_send_code.tr()),
                Text(emailTC.text.trim(), style: kTitleStyle.red),
                const SpaceY(16),
                PrimaryTextField(
                  hint: LocaleKeys.code.tr(),
                  controller: codeTC,
                  isRequired: false,
                ),
                buildCountdownTimer(),
                PrimaryButton(
                  onPressed: () => onVerifyCode(codeTC.text.trim()),
                  child: Text(LocaleKeys.verify.tr()),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

mixin CountdownMixin<T extends StatefulWidget> on State<T> {
  Timer? codeTimer;
  int expiredInSecond = 10;
  int resendDuration = 0;
  late ValueNotifier<int> timerNotifier;

  Future<void> resendCode();

  void startCountDownTimer() {
    timerNotifier.value = expiredInSecond;
    codeTimer?.cancel();
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerNotifier.value > 0) {
        timerNotifier.value -= 1;
      } else {
        timer.cancel();
        timerNotifier.value = expiredInSecond;
      }
    });
  }

  @override
  void initState() {
    timerNotifier = ValueNotifier<int>(expiredInSecond);
    resendDuration = expiredInSecond;
    super.initState();
  }

  @override
  void dispose() {
    timerNotifier.dispose();
    codeTimer?.cancel();
    codeTimer = null;
    super.dispose();
  }

  Widget buildCountdownTimer() {
    return ValueListenableBuilder<int>(
      valueListenable: timerNotifier,
      child: _buildResendInfo(),
      builder: (context, time, child) {
        if (codeTimer == null) {
          return const SizedBox();
        }
        return Column(
          children: [
            if (time <= resendDuration) child!,
            if (codeTimer?.isActive == true)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("($time)"),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildResendInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(tr(LocaleKeys.didnt_receive_code), style: kSubtitleStyle.setColor(Colors.grey)),
        SuraFlatButton(
          onPressed: resendCode,
          textColor: AppColor.primary,
          child: Text(LocaleKeys.resend_code.tr()),
        ),
      ],
    );
  }
}