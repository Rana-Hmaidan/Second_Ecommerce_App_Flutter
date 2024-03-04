import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/profile_cubit/profile_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/main_button.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/social_item.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();

  String? validateEmail(String value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter a valid email';
    }
  }

  String? validateUserName(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z]).{3,}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter a valid username';
    }
  }

   @override
  void dispose(){
    _emailController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    FlutterNativeSplash.remove();
    super.initState();
  }

  Future<void> editProfile(String uid) async {
    if (_formKey.currentState!.validate()) {
      await BlocProvider.of<ProfileCubit>(context).editProfile(
        uid,
        _emailController.text,
        _userNameController.text,
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final cubit = BlocProvider.of<ProfileCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is EditProfileLoading ||
          current is EditProfileLoaded ||
          current is EditProfileError,
      builder: (context, state) {
        if (state is EditProfileLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is EditProfileError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is EditProfileLoaded) {
          final user = state.user;
          return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24.0,),
                  CircleAvatar(
                    radius: size.width > 800 ? size.height * 0.2 :size.height * 0.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(size.width > 800 ? size.height * 0.2 :size.height * 0.1),
                      child: CachedNetworkImage(
                        imageUrl: user.imgUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8.0,),
                        TextFormField(
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: user.username,
                            prefixIcon: const Icon(FontAwesomeIcons.user),
                            prefixIconColor:  _userNameController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
                          ),
                          validator: (value) => validateUserName(value!),
                        ),
                        const SizedBox(height: 24.0,),
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: user.email,
                            prefixIcon:  const Icon(Icons.email),
                            prefixIconColor: _emailController.text.isNotEmpty ? Theme.of(context).colorScheme.primary : AppColors.grey,
                          ),
                          validator: (value) => validateEmail(value!),
                        ),
                        const SizedBox(height: 36.0,),
                        Text(
                          'Account Linked With',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12.0,),
                        SocialItem(
                            icon: FontAwesomeIcons.google,
                            title: 'Google',
                            color: AppColors.red,
                            actionIcon: Icons.link,
                            onTap: (){},
                        ),
                        const SizedBox(height: 36.0,),
                        MainButton(
                          onPressed: () => editProfile(user.id),
                          title: 'Save Changes',
                        ),     
                      ],
                    ),
                  ),
                ],
              ),
            ),
                    ),
          );
        } else {
          return const SizedBox();
        }
      }
    );
  }
}

  // ElevatedButton(
                      //   onPressed: (){
                      //     if (_formKey.currentState!.validate()) {
                      //       cubit.editProfile(
                      //         user.id, 
                      //         _emailController.text, 
                      //         _userNameController.text,
                      //       );
                      //     }
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Theme.of(context).primaryColor,
                      //     foregroundColor: AppColors.white,
                      //   ),
                      //   child: Text(
                      //       'Save Changes',
                      //       style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      //           color: AppColors.white,
                      //           fontWeight: FontWeight.w600),
                      //   ),
                      // ),