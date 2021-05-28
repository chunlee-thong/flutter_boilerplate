import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../constant/app_dimension.dart';
import '../constant/style_decoration.dart';
import '../ui/widgets/buttons/primary_button.dart';
import '../ui/widgets/common/ui_helper.dart';
import '../ui/widgets/form_input/primary_text_field.dart';

enum VerificationStep {
  sendCode,
  Verify,
}

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with SuraFormMixin {
  late TextEditingController emailTC, codeTC;
  VerificationStep step = VerificationStep.sendCode;
  Timer? codeTimer;
  ValueNotifier timerNotifier = ValueNotifier<int>(60);

  Future<void> onSendVerificationCode() async {
    if (isFormValidated) {
      try {
        if (codeTimer?.isActive ?? false) throw "Can't resend code now";
        String email = emailTC.text.trim();
        await Future.delayed(Duration(seconds: 2));
        startCountDownTimer();
        setState(() {
          step = VerificationStep.Verify;
        });
      } catch (e) {
        UIHelper.showErrorDialog(context, e);
      }
    }
  }

  Future<void> onVerifyCode(String code) async {}

  void startCountDownTimer() {
    codeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerNotifier.value > 0) {
        timerNotifier.value -= 1;
      } else {
        timer.cancel();
        timerNotifier.value = 60;
      }
    });
  }

  @override
  void initState() {
    codeTC = TextEditingController();
    emailTC = TextEditingController(text: "chunlee@gmail.com");
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
              Text("Reset your Password", style: kHeaderStyle),
              SpaceY(24),
              PrimaryTextField(
                controller: emailTC,
                hint: "Email",
                readOnly: step == VerificationStep.Verify,
              ),
              if (step == VerificationStep.sendCode) ...[
                PrimaryButton(
                  onPressed: onSendVerificationCode,
                  child: Text("Send Code"),
                ),
              ] else ...[
                Text("We have send a verification code to"),
                Text(emailTC.text.trim(), style: kTitleStyle.red),
                SpaceY(16),
                PrimaryTextField(
                  hint: "Code",
                  controller: codeTC,
                  isRequired: false,
                ),
                buildCountdownTimer(),
                SpaceY(16),
                PrimaryButton(
                  onPressed: () => onVerifyCode(codeTC.text.trim()),
                  child: Text("Verify"),
                ),
                buildFooter(),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountdownTimer() {
    return Center(
      child: SuraNotifier(valueNotifier: timerNotifier, builder: (dynamic timer) => Text("$timer")),
    );
  }

  Widget buildFooter() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Didn't receive code?"),
          SuraFlatButton(
            onPressed: onSendVerificationCode,
            child: Text(
              "Resend Code",
              style: Theme.of(context).textTheme.button!.primary,
            ),
          ),
        ],
      ),
    );
  }
}
