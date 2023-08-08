import 'package:flutter/material.dart';
import 'package:napp/screens/news_screen.dart';
import 'package:napp/utilities/colors.dart';
import 'package:napp/view_models/news_article_list_view_model.dart';
import 'package:provider/provider.dart';

String myValue = 'general';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: themeColor,
        appBarTheme: const AppBarTheme(
          color: themeColor,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => NewsArticleListViewModel(),
        )
      ], child: const NewsScreen()),
    );
  }
}
