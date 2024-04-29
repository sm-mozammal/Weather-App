import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../provider/forecast_provider.dart';

class ActionButton extends StatelessWidget {
  final int index;
  final String buttonName;
  final VoidCallback? onTap;
  const ActionButton({
    super.key,
    required this.buttonName,
    this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        decoration: ShapeDecoration(
          color: Provider.of<ForecastProvider>(context, listen: false).index ==
                  index
              ? Colors.white.withOpacity(0.10000000149011612)
              : Colors.black.withOpacity(0.10000000149011612),
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
              buttonName,
              textAlign: TextAlign.center,
              style: TextFontStyle.headline14StyleInter700,
            ),
          ],
        ),
      ),
    );
  }
}
