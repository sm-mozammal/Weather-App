import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/colors.gen.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.26, -0.97),
              end: Alignment(-0.26, 0.97),
              colors: [
                AppColors.c91A3DE,
                AppColors.c546FC5,
              ],
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: AppColors.c97ABFF,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: child),
    );
  }
}
