import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swivt_assignment/app/theme/app_colors.dart';
import 'package:swivt_assignment/app/theme/app_styles.dart';

class NewsCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? source;

  const NewsCard(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.source})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 10.sw,
      alignment: Alignment.topCenter,
      child: ColoredBox(
        color: AppColors.appWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
                width: 120.w,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.darkBlueShade2, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(imageUrl == ''
                            ? 'https://www.gizmohnews.com/assets/images/news.png'
                            : imageUrl ??
                                'https://www.gizmohnews.com/assets/images/news.png'),
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 18,
                            child: Text(
                                source == '' ? 'Unknown Source' : source ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.regularText12
                                    .copyWith(color: AppColors.darkBlueShade2)),
                          ),
                          const Spacer(
                            flex: 6,
                          ),
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: Text(widget.newsTime,
                          //       style: AppStyle.regularText12
                          //           .copyWith(color: AppColors.darkBlueShade2)),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        title == '' ? 'No title' : title ?? 'No title',
                        style: AppStyle.boldText14
                            .copyWith(color: AppColors.darkBlueShade1),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.darkBlueShade2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
