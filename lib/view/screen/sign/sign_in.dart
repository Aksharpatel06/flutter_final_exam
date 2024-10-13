import 'package:flutter/material.dart';
import 'package:flutter_final_exam/utils/color.dart';
import 'package:flutter_final_exam/view/controller/home_controller.dart';
import 'package:flutter_final_exam/view/helper/google_services.dart';
import 'package:flutter_final_exam/view/screen/home/home_page.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(
                Icons.edit_note,
                color: primaryColor,
                size: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Welcome to MyNotes",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const Text(
                "Keep your Note safes",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: homeController.txtEmail,
                decoration: const InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: primaryColor),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: ternaryColor))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: homeController.txtPwd,
                decoration: const InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: primaryColor),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: ternaryColor))),
              ),
              const SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: MaterialButton(
                  height: 60,
                  minWidth: 250,
                  color: primaryColor,
                  child: const Text(
                    "LogIn",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    String status = await GoogleServices.googleServices
                        .createAccount(homeController.txtEmail.text,
                            homeController.txtPwd.text);
                    if (status == 'Success') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    }
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
