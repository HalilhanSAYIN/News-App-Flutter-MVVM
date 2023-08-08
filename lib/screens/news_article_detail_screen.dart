import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utilities/style.dart';
import '../utilities/colors.dart';
import '../view_models/news_article_view_model.dart';
import '../widgets/image_widget.dart';

class NewsArticleDetailsScreen extends StatelessWidget {
  final NewsArticleViewModel article;
  const NewsArticleDetailsScreen(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewController controller;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(article.url.toString()));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    article.author != null
                        ? Text(
                            article.author.toString(),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            'Author',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 32.0, bottom: 16, left: 24, right: 24),
          child: Column(
            children: [
              Text(
                article.title.toString(),
                style: detailScreenTitleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48, bottom: 48),
                child: SizedBox(
                  height: 200,
                  child: ImageWidget(
                    imgUrl: article.imageUrl.toString(),
                  ),
                ),
              ),
              article.description != null
                  ? Text(
                      article.description.toString(),
                      style: detailScreenDescriptionTextStyle,
                    )
                  : const Text(
                      "Sorry, there was a problem retrieving the news content.",
                      style: detailScreenDescriptionTextStyle,
                    ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: WebViewWidget(controller: controller),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Close',
                                  style: TextStyle(color: themeColor),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Click to see the details of the news",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontStyle: FontStyle.italic),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
