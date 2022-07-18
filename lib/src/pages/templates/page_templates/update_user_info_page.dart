import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../core/constant/locale_keys.dart';
import '../../../core/style/dimension.dart';
import '../../../core/style/textstyle.dart';
import '../../../core/utilities/exception_handler.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/form_input/primary_dropdown_button.dart';
import '../../../widgets/form_input/primary_text_field.dart';
import '../../../widgets/ui_helper.dart';

class UpdateUserInfoPage extends StatefulWidget {
  const UpdateUserInfoPage({Key? key}) : super(key: key);
  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> with SuraFormMixin, AfterBuildMixin {
  late TextEditingController firstNameTC;
  late TextEditingController lastNameTC;
  late TextEditingController dobTC;
  late TextEditingController countryTC;

  String? gender;
  List<String> genders = ["Male", "Female"];
  late DateTime selectedDOB;

  Future<void> onSubmit() async {
    if (isFormValidated) {
      await ExceptionHandler.run(context, () async {
        String firstname = firstNameTC.text.trim();
        String lastname = lastNameTC.text.trim();
        String country = countryTC.text.trim();
      });
    }
  }

  void onPickDob() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedDOB = pickedDate;
      dobTC.text = selectedDOB.formatDate();
    }
  }

  @override
  void initState() {
    firstNameTC = TextEditingController();
    lastNameTC = TextEditingController();
    dobTC = TextEditingController();
    countryTC = TextEditingController();
    super.initState();
  }

  @override
  void afterBuild(BuildContext context) {}

  @override
  void dispose() {
    firstNameTC.dispose();
    lastNameTC.dispose();
    dobTC.dispose();
    countryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: ""),
      body: SingleChildScrollView(
        padding: AppDimension.pageSpacing,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.update.tr(args: [(LocaleKeys.profile.tr())]), style: kHeaderStyle),
            const SpaceY(24),
            buildForm(),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PrimaryTextField(
            controller: firstNameTC,
            hint: tr(LocaleKeys.first_name),
          ),
          PrimaryTextField(
            controller: lastNameTC,
            hint: tr(LocaleKeys.last_name),
          ),
          PrimaryTextField(
            controller: dobTC,
            hint: tr(LocaleKeys.date_of_birth),
            onTap: onPickDob,
          ),
          PrimaryDropDownButton(
            options: genders,
            value: gender,
            onChanged: (String? value) {
              setState(() {
                gender = value;
              });
            },
            hint: tr(LocaleKeys.gender),
          ),
          PrimaryButton(
            onPressed: onSubmit,
            child: Text(tr(LocaleKeys.update, args: [""])),
          ),
        ],
      ),
    );
  }
}
