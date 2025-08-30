
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loading_indicator_item.dart';

class TasksLoadingIndicator extends StatelessWidget {
  const TasksLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context,index)=>ItemLoadingIndicator(),
          separatorBuilder: (context,index)=>SizedBox(height: 20.h,),
          itemCount: 10
      ),
    );
  }
}
