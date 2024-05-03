import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/styles/my_text.dart';
import 'package:igt_e_pass_app/utils/my_navigator.dart';

class BeenHereEmployeePage extends StatelessWidget {
  const BeenHereEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SelectedEmployeeBody();
  }
}

class SelectedEmployeeBody extends StatelessWidget {
  const SelectedEmployeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "Vistor Detail",
      body: SingleChildScrollView(
          child: Container(
              //color: Color(0xFF01497c),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  EntryField(
                    label: "Select employees",
                    hint: "Select employees",
                    suffixIcon: Icons.arrow_drop_down,
                  ),
                  const SizedBox(height: 5),
                  EntryField(
                      keyboardType: TextInputType.multiline,
                      label: "Purpose",
                      hint: "Write your purpose",
                      maxLines: null,
                      minLines: 8),
                ],
              ))),
      bottomButton: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () => Nav.pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(
                      width: 2.0,
                      color: Colors.red,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Cancel',
                    style: MyText.button(context)?.copyWith(color: Colors.red),
                  ),
                )),
            ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Continue',
                    style: MyText.button(context)!.copyWith(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
