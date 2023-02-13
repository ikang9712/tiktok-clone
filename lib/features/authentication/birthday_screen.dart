import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime initialDate = DateTime.now().subtract(const Duration(days: 4380));

  @override
  void initState() {
    super.initState();
    _setTextFieldData(initialDate);
  }

  void _onNextTap() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const InterestsScreen()),
        (route) => false);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose(); // this stays at the end.
  }

  void _setTextFieldData(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "When's your birthday?",
            style: TextStyle(
              fontSize: Sizes.size24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gaps.v8,
          const Text(
            "Your birthday won't be shown publicly.",
            style: TextStyle(
              color: Colors.black54,
              fontSize: Sizes.size16,
            ),
          ),
          Gaps.v16,
          TextField(
            controller: _birthdayController,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          Gaps.v16,
          GestureDetector(
            onTap: _onNextTap,
            child: const FormButton(disabled: false, text: "Next"),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          maximumDate: initialDate,
          initialDateTime: initialDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldData,
        ),
      )),
    );
  }
}
