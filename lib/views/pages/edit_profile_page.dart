import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _userNameController, _emailController;
  late FocusNode _userNameFocusNode,_emailFocusNode;
 // String? _userName ,_email;

  @override
  void initState(){
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _emailFocusNode = FocusNode();
    _userNameFocusNode = FocusNode();
    super.initState();
  }

   @override
  void dispose(){
    _emailController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  // Future<void> editProfile(String uid) async {
  //   if (_formKey.currentState!.validate()) {
  //     await BlocProvider.of<ProfileCubit>(context).EditProfile(
  //       uid,
  //       _emailController.text,
  //       _userNameController.text,
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    //final user = ModalRoute.of(context)!.settings.arguments as UserData;

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
          return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24.0,),
                ClipRRect(
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
                const SizedBox(height: 16.0,),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24.0,),
                      TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.name,
                        focusNode: _userNameFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: (){
                          _userNameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your username';
                          }else if(value.length < 3){
                            return 'Username must be at least 3 characters';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: user.username,
                          prefixIcon: const Icon(Icons.person_outline),
                          prefixIconColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 36.0,),
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12.0,),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: (){
                          _emailFocusNode.unfocus();
                          if (_formKey.currentState!.validate()) {
                            cubit.editProfile(
                              user.id, 
                              _emailController.text, 
                              _userNameController.text,
                            );
                          }
                        },
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your email';
                          }else if(!value.contains('@')){
                            return 'Please enter a valid email';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: user.email,
                          prefixIcon:  const Icon(Icons.email),
                          prefixIconColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 36.0,),
                      Text(
                        'Account Linked With',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                      BlocConsumer<ProfileCubit, ProfileState>(
                        bloc: cubit,
                        listenWhen: (previous, current) =>
                          current is SaveChangesSuccess || 
                          current is SaveChangesFailure,
                        listener: (context, state) {
                        if (state is SaveChangesSuccess) {
                          Navigator.pushNamed(context, AppRoutes.editProfile);
                        } else if (state is SaveChangesFailure) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                              title: const Text('Error'),
                              content: Text(state.message),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                              );
                          });
                        }
                        },
                      buildWhen: (previous, current) =>
                        current is SaveChangesLoading ||
                        current is SaveChangesSuccess ||
                        current is SaveChangesFailure ,
                      builder: (context, state) {
                        if (state is SaveChangesLoading) {
                          return const MainButton(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return MainButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                            cubit.editProfile(
                              user.id, 
                             _emailController.text, 
                             _userNameController.text,
                            );
                            }
                          },
                          title: 'Save Changes',
                          );
                        },
                      ),        
                    ],
                  ),
                ),
              ],
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