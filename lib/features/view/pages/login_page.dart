// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/config/service_locator.dart';
import 'package:notes_app/core/res/app_color.dart';
import 'package:notes_app/core/res/app_images.dart';
import 'package:notes_app/core/res/app_string.dart';
import 'package:notes_app/core/res/app_style.dart';
import 'package:notes_app/features/view/pages/notes_page.dart';
import 'package:notes_app/features/view/provider/immutabel_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Form(
          key: formkey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                homeImage,
                width: 300,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                ),
                child: SizedBox(
                  width: 340,
                  height: 60,
                  child: TextFormField(
                    style: TextStyle(color: white),
                    controller: email,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'The user name is to short';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: hintStyle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                ),
                child: SizedBox(
                  width: 340,
                  height: 60,
                  child: TextFormField(
                    style: TextStyle(color: white),
                    controller: password,
                    obscureText: true,
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'The password is to week';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.visibility_off,
                        size: 22,
                      ),
                      labelText: "Password",
                      labelStyle: hintStyle,
                    ),
                  ),
                ),
              ),
              Consumer(builder: (context, ref, _) {
                return InkWell(
                  onTap: () async {
                    if (email.text.isEmpty && password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(PLEASE),
                        ),
                      );
                    } else {
                      final result = await ref.read(addToUserProvider).insert(
                          {'email': email.text, 'password': password.text});

                      if (result == true) {
                        core
                            .get<SharedPreferences>()
                            .setString('email', email.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotesPage(),
                          ),
                        );
                      } else {
                        Text(EXIST);
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    alignment: Alignment.center,
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: BorderRadius.circular(44),
                    ),
                    child: Text(
                      SIGNIN,
                      style: signInStyle,
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ));
  }
}
