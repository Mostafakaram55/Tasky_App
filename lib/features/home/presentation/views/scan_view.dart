
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:tasky_app/config/routes/app_routes.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/home/presentation/cubits/get_task_cubit/get_task_states.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../core/widgets/arrow_left_icon.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../cubits/get_task_cubit/get_task_cubit.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key, required this.contextForBloc});

  final BuildContext contextForBloc;

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await widget.contextForBloc.read<GetTasksCubit>().getTaskById(taskId: scanData.code!);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTasksCubit, GetTasksStates>(
      listener: (context, state) {
        if (state is GetTaskByIdSuccess) {
          AppRouter.navigateTo(
            AppRouter.detailsView,
            extra: widget.contextForBloc.read<GetTasksCubit>().taskById,
          );
        }else if(state is GetTaskByIdSuccess){

        }else if(state is GetTaskByIdLoading){
          controller?.stopCamera();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is GetTaskByIdLoading,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor:ColorManager.buttonColor,
              title:CustomTextWidget(title: TextManager.scan, colorText: Colors.white, size: 16.sp, fontWeight: FontWeight.w700),
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ArrowLeftIcon(
                  operation: AppRouter.goBack,
                ),
              ),
              leadingWidth: 50.w,
            ) ,
            body: QRView(
              key: GlobalKey(debugLabel: 'QR'),
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: ColorManager.buttonColor,
                borderRadius: 10.r,
                cutOutSize: MediaQuery.sizeOf(context).width * 0.8,
                borderWidth:15.r,
                borderLength: 25.h,
              ),
            ),
          ),
        );
      },
    );
  }
}