import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/colors.gen.dart';

class TextFontStyle {
//Initialising Constractor
  TextFontStyle._();

  //new
  static final headline32StyleInter = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 32.sp, fontWeight: FontWeight.w700);
  static final headline12StyleInter = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 12.sp, fontWeight: FontWeight.w400);
  static final headline70StyleInter = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 70.sp, fontWeight: FontWeight.w400);
  static final headline18StyleInter = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 18.sp, fontWeight: FontWeight.w600);
  static final headline18StyleInter400 = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 18.sp, fontWeight: FontWeight.w400);
  static final headline24StyleInter = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 24.sp, fontWeight: FontWeight.w400);
  static final headline16StyleInter = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 16.sp, fontWeight: FontWeight.w400);
  static final headline14StyleInter700 = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 14.sp, fontWeight: FontWeight.w700);
  static final headline14StyleInter = GoogleFonts.inter(
      color: AppColors.cFFFFFF, fontSize: 14.sp, fontWeight: FontWeight.w400);
  static final headline20StyleInter = GoogleFonts.inter(
      color: AppColors.c000000, fontSize: 20.sp, fontWeight: FontWeight.w700);
}
