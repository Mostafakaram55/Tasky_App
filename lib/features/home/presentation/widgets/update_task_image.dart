
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/widgets/uplad_image_button.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../cubits/task_crud_cubit/task_curd_cubit.dart';
import '../cubits/task_crud_cubit/task_curd_states.dart';
import 'alert_dialog_widget.dart';

class UpdateTaskImage extends StatelessWidget {
  const UpdateTaskImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskOperationsCubit,TaskOperationStates>(
      builder: (contextForBloc,state){
        return  GestureDetector(
          onTap: (){
            showAdaptiveDialog(
              context: contextForBloc,
              builder: (context) {
                return AlertDialogWidget(
                  iconType:IconBroken.Edit ,
                  title: TextManager.editeImage,
                  items: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: UploadImageButton(
                        operation: (){
                          contextForBloc.read<TaskOperationsCubit>().uploadTaskImageFromCamera();
                          context.pop();
                        },
                        titleButton:TextManager.tackPhoto,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: UploadImageButton(
                        titleButton: TextManager.chooseFile,
                        operation: (){
                          contextForBloc.read<TaskOperationsCubit>().uploadTaskImageFromGallery();
                          context.pop();
                        },

                      ),
                    ),
                  ],
                  subTitle: TextManager.pickImageTitle,
                );
              },
            );
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(10.r),
            dashPattern: [6, 3],
            color: ColorManager.buttonColor,
            strokeWidth: 1,
            child:Container(
              height: MediaQuery
                  .sizeOf(context)
                  .height / 3.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: context.read<TaskOperationsCubit>().imageTask==null?ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child:CustomNetworkImage(
                  image: imageUrl ,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ):
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(
                  context.read<TaskOperationsCubit>().imageTask!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
