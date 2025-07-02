import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../Const/app_colors.dart';
class HeaderShimmer extends StatelessWidget {
  const HeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24,
            width: 130,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            margin: EdgeInsets.only(bottom: 12),
          ),

          Gap(18),
          Row(
            children: [
              CircleAvatar(radius: 25, backgroundColor: Colors.white),
              Gap(13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 120,
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 6),
                  ),
                  Container(height: 14, width: 180, color: Colors.white),
                ],
              ),
            ],
          ),

          SizedBox(height: 28),

          // Marquee shimmer bar
          Container(height: 30, width: double.infinity, color: Colors.white),
        ],
      ),
    );
  }
}