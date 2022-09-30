import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/features/authentication/screen/forgot_password_screen.dart';
import 'package:street_light_management/main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void dispose() {
    emailAddressController.dispose();

    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30 - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailAddressController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("E-Mail"),
                  prefixIcon: Icon(Icons.email_outlined)),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                } else if (!(GetUtils.isEmail(value))) {
                  return 'Please enter your valid email address';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Password",
                border: OutlineInputBorder(),
                // suffixIcon: IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.remove_red_eye_sharp),
                // ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a Password';
                } else if (value.length < 8) {
                  return 'Minimum 8 characters required';
                }
                return null;
              },
            ),
            const SizedBox(height: 30 - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Get.to(() => ForgotPasswordScreen(
                        emailAddressController: emailAddressController));
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
            Hero(
              tag: 'submit_button',
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
            
                      await signIn();
                    } else {
                      return;
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator())));
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddressController.text.trim(),
        password: passwordController.text.trim(),
      );
      print(response);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      ShowErrorSnackBar.showSnackBar(text: e.message!);
    }
    navigatorKey.currentState!.pop();
  }
}
