import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import '../../../../utils/api_constants.dart';
import '../../model/get_category_model.dart';
import 'category_list.dart';

class CatagoriesWidget extends StatelessWidget {
  final List<CategoryList>? categories;

  CatagoriesWidget({Key? key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 2.h),
        child: Row(
          children: categories?.map((category) {
            return Padding(
              padding: EdgeInsets.only(right: 4.h),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff09BBB5).withOpacity(.27),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: InkWell(
                      onTap: (){
                       Get.to(CategoryListScreen(cid:category.id.toString()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CachedNetworkImage(
                          imageUrl: ApiConstant.BASE_imgUrl + category.imageurl!,
                          width: 6.h,
                          height: 6.h,
                          placeholder: (context, url) => CircularProgressIndicator(color:  Color(0xff09BBB5).withOpacity(.27),),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: .7.h),
                  Text(
                    category.categoryname ?? '',
                    style: normalText,
                  ),
                ],
              ),
            );
          }).toList() ?? [],
        ),
      ),
    );
  }
}
