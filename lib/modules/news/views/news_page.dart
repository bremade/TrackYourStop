import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/constants/colors.dart';
import 'package:track_your_stop/modules/news/provider/news_list_provider.dart';
import 'package:track_your_stop/outbound/interactor/mvg_news_interactor.dart';
import 'package:track_your_stop/outbound/models/news_line.dart';
import 'package:track_your_stop/outbound/models/news_response.dart';
import 'package:track_your_stop/shared/ui/bottom_app_bar.dart';
import 'package:track_your_stop/utils/app_theme.dart';
import 'package:track_your_stop/utils/logger.dart';
import 'package:track_your_stop/utils/transportation_type.util.dart';

final logger = getLogger("DeparturePage");

class NewsPage extends HookConsumerWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Card buildCard(String title, List<NewsLine> lines) {
      final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
      final containerColor =
          isDarkMode ? secondaryContainerColorDark : secondaryContainerColor;
      final textColor = isDarkMode
          ? onSecondaryContainerColorDark
          : onSecondaryContainerColor;
      final List<ImageProvider> transportationTypeAssets =
          getAssetListForTransportationType(
              lines.map((e) => e.typeOfTransport).toSet(),
              charOnly: true);
      return Card(
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            leading: Container(
              height: double.infinity,
              padding: const EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.5, color: textColor),
                ),
              ),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    maxWidth: 50,
                    minHeight: 20,
                    maxHeight: 100,
                  ),
                  child: FlutterImageStack.providers(
                    providers: transportationTypeAssets,
                    totalCount: transportationTypeAssets.length,
                    itemCount: transportationTypeAssets.length,
                    itemBorderWidth: 1,
                  )),
            ),
            title: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              lines.map((e) => e.name).toSet().join(", "),
            ),
          ),
        ),
      );
    }

    ListView buildListView(BuildContext context, List<NewsResponse> newsList) {
      List<Widget> newsCards = <Widget>[];
      for (var news in newsList) {
        logger.d(news.toJson());
        newsCards.add(buildCard(news.title, news.lines));
      }
      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: newsCards,
      );
    }

    Widget buildBody() {
      final Future<List<NewsResponse>> news = ref.watch(newsListProvider);
      return FutureBuilder(
          future: news,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<NewsResponse> newsData = snapshot.data;
                  if (newsData.isEmpty) {
                    return Center(
                        child:
                            Text(AppLocalizations.of(context)!.newsEmptyText));
                  }
                  return buildListView(context, newsData);
                }
            }
          });
    }

    return Scaffold(
      body: RefreshIndicator(
        child: buildBody(),
        onRefresh: () {
          // Refresh news provider and therefore main view data
          return ref.read(newsListProvider.notifier).state =
              MvgNewsInteractor.fetchNews();
        },
      ),
      bottomNavigationBar: BottomAppNavigationBar(),
    );
  }
}
