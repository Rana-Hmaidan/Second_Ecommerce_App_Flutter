import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/email_modal_bottomsheet.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/main_button.dart';

class EmailVerificationPage extends StatefulWidget {

  final String email;
  const EmailVerificationPage({super.key , required this.email});
  
  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {

  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      timer = Timer.periodic(const Duration(seconds: 5), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context, 
          builder: (ctx) => const EmailModalBottomsheet(),
        );
      
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Verification'
          ),
          centerTitle: true,
        ) ,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromARGB(255, 131, 98, 189),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.attach_email, 
                    color: AppColors.white
                  ),
                ),
              ),
              Text(
                'Verification Code',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We have to sent email verification to',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.email,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.grey,
                ),
              ), 
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Text(
                'Didn\'t recieve an email verification?',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: MainButton(
                  title: 'Resend',
                  onPressed: (){
                    try {
                      FirebaseAuth.instance.currentUser?.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                )
              ),
              const SizedBox(height: 30.0),
            ]
          ),
        ),
      ),
    );
  }
}