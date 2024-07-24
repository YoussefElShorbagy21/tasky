import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/modules/profile/cubit/profile_cubit.dart';
import 'package:tasky/shared/resources/asset_manager.dart';
import 'package:tasky/shared/resources/color_manager.dart';

import 'widget/profile_show_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Color(0xFF24252C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(ImageAssets.iconBack),
                  )
              ),
              body: Column(
                children: [
                  ProfileShow(
                    title: 'Name',
                    value: cubit.userModel?.displayName ?? '',
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone',
                              style: TextStyle(
                                color: Color(0x662F2F2F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Row(
                              children: [
                                Text(
                                  cubit.userModel?.username ?? '',
                                  style: const TextStyle(
                                    color: Color(0x992F2F2F),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(text: cubit.userModel?.username ?? ''));
                                    CherryToast.success(
                                      title: const Text('Copied to Clipboard'),
                                      animationType: AnimationType.fromTop,
                                    ).show(context);
                                  },
                                  icon: Icon(Icons.copy_rounded,color: ColorManager.primary,),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  ProfileShow(
                    title: 'Level',
                    value: cubit.userModel?.level ?? '',
                  ),

                  ProfileShow(
                    title: 'Years of experience',
                    value: '${cubit.userModel?.experienceYears.toString()} years',
                  ),

                  ProfileShow(
                    title: 'Location',
                    value: cubit.userModel?.address ?? '',
                  ),
                ],
              )
          );
        },
      ),
    );
  }
}


