import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.grey.withOpacity(0.5), width: 1),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search something...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Icon(PhosphorIcons.sliders_horizontal),
            ],
          ),
        )
      );
  }
}