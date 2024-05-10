import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController searchController;
  const SearchBox({Key? key, required this.searchController}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      cursorColor: Colors.white,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      style: TextStyle(
        fontFamily: "Inter",
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      ),
      decoration: InputDecoration(
        hintText: 'Seach tasks',
        filled: true,
        fillColor: fiord,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
            fontFamily: "Inter",
            color: slateGray,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: goldenRod),
        ),
        prefixIcon: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/search_icon.svg',
            height: 20.h,
          ),
          onPressed: () {},
        ),
      ),
    );

  }
}
