import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:curt_task/core/utililes/app_strings.dart';
import 'package:curt_task/core/utililes/font_styles.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    FontStyles.init();

    return Scaffold(
      backgroundColor: background,
        body: SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Image.asset(AppStrings.welcomeImage,),

                Expanded(child: Container(),),
              Column(
                children: [
                  Text(
                    AppStrings.welcomeToCurtTask,
                    style:FontStyles.welcomHeader,
                  ),
                  Text(
                    AppStrings.pleaseLoginOrSignUpToContinue,
                    style: FontStyles.welcomBody,     )
                ],
              ),
              const SizedBox(height: 120),
              Expanded(child: Container(),),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppStrings.loginRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: wight,
                        backgroundColor: darkPurple,
                        shape:const  RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),

                      child: Text(
                        'Login'.toUpperCase(),
                        style: FontStyles.welcomButton
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),

                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,AppStrings.signUpRoute);

                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Sign Up'.toUpperCase(),
                        style: FontStyles.welcomButton,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
