import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply/home_page.dart';
import 'package:reply/model/email_model.dart';
import 'package:reply/styling.dart';

void main() {
  runApp(ReplyApp());
}

class ReplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailModel>.value(value: EmailModel()),
      ],
      child: MaterialApp(
        title: 'Reply',
        theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.notWhite,
          canvasColor: AppTheme.notWhite,
          accentColor: AppTheme.orange,
          textTheme: AppTheme.textTheme,
        ),
        home: HomePage(),
      ),
    );
  }
}
