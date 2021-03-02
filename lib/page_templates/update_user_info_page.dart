import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../constant/app_dimension.dart';
import '../constant/style_decoration.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/common/ui_helper.dart';
import '../widgets/form_input/primary_dropdown_button.dart';
import '../widgets/form_input/primary_text_field.dart';

class UpdateUserInfoPage extends StatefulWidget {
  UpdateUserInfoPage({Key key}) : super(key: key);
  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage>
    with SuraFormMixin, AfterBuildMixin {
  TextEditingController firstNameTC;
  TextEditingController lastNameTC;
  TextEditingController dobTC;

  String gender;
  List<String> genders = ["Male", "Female"];
  DateTime selectedDOB;

  Future<void> onSubmit() async {
    if (isFormValidated) {
      try {
        String firstname = firstNameTC.text.trim();
        String lastname = lastNameTC.text.trim();

        bool result = await Future.value(true);
      } catch (e) {
        UIHelper.showErrorDialog(context, e);
      }
    }
  }

  void onPickDob() async {
    DateTime pickedDate = await showDatePicker(
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
    gender = genders[0];
    firstNameTC = TextEditingController();
    lastNameTC = TextEditingController();
    dobTC = TextEditingController();
    super.initState();
  }

  @override
  void afterBuild(BuildContext context) {
    // TODO: implement afterBuild
  }

  @override
  void dispose() {
    firstNameTC.dispose();
    lastNameTC.dispose();
    dobTC.dispose();
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
            Text("Update your info", style: kHeaderStyle),
            SpaceY(24),
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
            hint: "First name",
          ),
          PrimaryTextField(
            controller: lastNameTC,
            hint: "Last name",
          ),
          PrimaryTextField(
            controller: dobTC,
            hint: "Date of birth",
            onTap: onPickDob,
          ),
          PrimaryDropDownButton(
            options: genders,
            value: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            },
          ),
          PrimaryButton(
            onPressed: onSubmit,
            child: Text("Change Password"),
          ),
        ],
      ),
    );
  }
}
