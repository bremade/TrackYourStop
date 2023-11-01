import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/news/provider/news_list_provider.dart';
import 'package:track_your_stop/modules/news/ui/news_view.dart';
import 'package:track_your_stop/outbound/models/news_response.dart';
import 'package:track_your_stop/shared/ui/bottom_app_bar.dart';

class NewsPage extends HookConsumerWidget {
  const NewsPage({Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context, WidgetRef ref) {
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
                      child: Text(AppLocalizations.of(context)!.newsEmptyText));
                }
                return buildListView(ref, context, newsData);
              }
          }
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        child: _buildBody(context, ref),
        onRefresh: () {
          // Refresh news provider and therefore main view data
          return ref.refresh(newsListProvider);
        },
      ),
      bottomNavigationBar: const BottomAppNavigationBar(),
    );
  }
}
