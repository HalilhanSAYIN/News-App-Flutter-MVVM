import 'package:flutter/material.dart';
import 'package:napp/main.dart';
import 'package:provider/provider.dart';

import '../utilities/const.dart';
import '../view_models/news_article_list_view_model.dart';
import '../widgets/news_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false).topNews();
  }

  Future<void> _refreshData() async {
    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .newsByCategory(myValue);
    await Future.delayed(Duration(seconds: 2));
    print("refresh data çalıştı ");
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<NewsArticleListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.black,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(24)),
            onSelected: (value) {
              setState(() {
                myValue = value;
                print(myValue);
              });
              listViewModel.newsByCategory(Const.categories[value]!);
            },
            icon: const Icon(
              Icons.category,
              color: Colors.white,
            ),
            itemBuilder: (_) {
              return Const.categories.keys
                  .map((v) => PopupMenuItem(
                        value: v,
                        child: Text(v),
                        textStyle: const TextStyle(color: Colors.white),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(child: NewsGrid(listViewModel.articles))],
          ),
        ),
      ),
    );
  }
}
