import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swivt_assignment/app/theme/app_colors.dart';
import 'package:swivt_assignment/app/theme/app_styles.dart';
import 'package:swivt_assignment/components/custom_app_bar.dart';

import 'package:swivt_assignment/features/news/bloc/news_bloc.dart';
import 'package:swivt_assignment/features/news/views/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    Key? key,
  }) : super(key: key);
  static const String route = '/newsScreenRoute';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appWhite,
        appBar: buildCustomAppBar(pageTitle: 'Business News'),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial || state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NewsLoadSuccess) {
              return ListView.separated(
                  padding: EdgeInsets.only(top: 16.h),
                  separatorBuilder: (BuildContext context, int index) {
                    return const ColoredBox(
                        color: AppColors.appWhite,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 1.5,
                            height: 2,
                          ),
                        ));
                  },
                  itemCount: state.newsList.length,
                  itemBuilder: (context, index) {
                    final news = state.newsList[index];
                    return NewsCard(
                        imageUrl: news.urlToImage ?? '',
                        title: news.title ?? '',
                        source: news.source ?? '');
                  });
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ));
  }
}
