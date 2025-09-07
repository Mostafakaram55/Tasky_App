import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/features/profile/presentation/widgets/user_data_item.dart';

import '../../../../core/widgets/copy_widget.dart';
import '../../../home/presentation/widgets/loading_indicator_item.dart';
import '../cubits/profile_cubit.dart';
import '../cubits/profile_states.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    ProfileCubit.get(context).getProfileData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var userdata=context.read<ProfileCubit>().userEntity;
        if(state is SuccessProfile){
          return SingleChildScrollView(
            child: Column(
              children: [
                UserDataItem(
                  title: 'Name',
                  subtitle:userdata!.displayName,
                ),
                SizedBox(height: 15.h,),
                UserDataItem(
                    title: 'Phone',
                    subtitle:userdata.username,
                    textCopy:CopyIconButton(textToCopy:userdata.username,)
                ),
                SizedBox(height: 15.h,),
                UserDataItem(
                  title: 'Level',
                  subtitle:userdata.level,
                ),
                SizedBox(height: 15.h,),
                UserDataItem(
                  title: 'Years of experience',
                  subtitle:'${userdata.experienceYears.toString()} Years',
                ),
                SizedBox(height: 15.h,),
                UserDataItem(
                  title: 'Location',
                  subtitle:userdata.address,
                ),
              ],
            ),
          );
        }
        else if (state is ErrorProfile){
          return Center(child: Text(state.message));
        }

        else {
          return ListView.separated(
            separatorBuilder:  (context,index)=>SizedBox(height: 10.h,),
            itemBuilder: (context,index)=>ItemLoadingIndicator(),
            itemCount: 5,
          );
        }
      },
    );
  }
}
