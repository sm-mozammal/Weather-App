import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/helpers/ui_helpers.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.71, -0.71),
              end: Alignment(-0.71, 0.71),
              colors: [
                AppColors.c97ABFF,
                AppColors.c123597,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dhaka',
                  style: TextFontStyle.headline32StyleInter,
                ),
                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.icons.location),
                    Text('Current Location',
                        textAlign: TextAlign.center,
                        style: TextFontStyle.headline12StyleInter)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 135.w,
                      height: 130.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.weatherapi.com/weather/64x64/day/116.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text('13\u00B0',
                        textAlign: TextAlign.right,
                        style: TextFontStyle.headline122StyleInter)
                  ],
                ),
                Text(
                  'Partly Cloud  -  H:17o  L:4o',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.headline18StyleInter,
                ),
                UIHelper.verticalSpaceMediumLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ActionButton(),
                    UIHelper.horizontalSpaceSmall,
                    const ActionButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.h,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.10000000149011612),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today',
            textAlign: TextAlign.center,
            style: TextFontStyle.headline14StyleInter700,
          ),
        ],
      ),
    );
  }
}
