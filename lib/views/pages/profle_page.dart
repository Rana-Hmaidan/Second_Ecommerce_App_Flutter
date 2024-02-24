import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/models/user_data.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/profile_list_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final user = ModalRoute.of(context)!.settings.arguments as UserData;

    return SafeArea(
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ProfileListTile(
                    leadingIcon: Icons.person_outline,
                    title: "Edit Profile",
                    onTapItem: (){
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        AppRoutes.editProfile,
                        arguments: user.id,
                      );
                    },
                  ),
                  ProfileListTile(
                    leadingIcon: Icons.password,
                    title: "Change Password",
                    onTapItem: (){},
                  ),
                  ProfileListTile(
                    leadingIcon: Icons.notifications_outlined,
                    title: "Notifications",
                    onTapItem: (){},
                  ),
                  ProfileListTile(
                    leadingIcon: Icons.security_outlined,
                    title: "Security",
                    onTapItem: (){},
                  ),
                  ProfileListTile(
                    leadingIcon: Icons.language_outlined,
                    title: "Language",
                    onTapItem: (){},
                  ),
                  const SizedBox(height: 24,),
                  Text(
                    'Preferences',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ProfileListTile(
                    leadingIcon: Icons.policy_outlined,
                    title: "Legal and Policies",
                    onTapItem: (){},
                  ),
                  ProfileListTile(
                    leadingIcon: Icons.help_center_outlined,
                    title: "Help & Support",
                    onTapItem: (){},
                  ),
                  ProfileListTile(
                    leadingIcon: Icons.logout_outlined,
                    title: "Logout",
                    onTapItem: (){},
                  ),
                //const Divider( indent: 20, endIndent: 20,),
              ],
            ),
          ),
      ),
    );
  }
}