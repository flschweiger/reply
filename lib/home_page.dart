import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply/editor_page.dart';
import 'package:reply/list_page.dart';
import 'package:reply/model/email_model.dart';
import 'package:reply/styling.dart';
import 'package:reply/transition/scale_out_transition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  final GlobalKey _fabKey = GlobalKey();
  final PageRouteBuilder<void> _initialRoute =
      PageRouteBuilder<void>(pageBuilder: (BuildContext context, _, __) => ListPage());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: ScaleOutTransition(
          child: Navigator(
            key: _navigatorKey,
            onGenerateRoute: (RouteSettings settings) {
              if (settings.name == Navigator.defaultRouteName) {
                return _initialRoute;
              }
            },
          ),
        ),
        bottomNavigationBar: _bottomNavigation,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _fab,
      ),
    );
  }

  Widget get _bottomNavigation {
    final Animation<Offset> slideIn = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: ModalRoute.of(context).animation, curve: Curves.ease));
    final Animation<Offset> slideOut = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1))
        .animate(CurvedAnimation(parent: ModalRoute.of(context).secondaryAnimation, curve: Curves.fastOutSlowIn));

    return SlideTransition(
      position: slideIn,
      child: SlideTransition(
        position: slideOut,
        child: BottomAppBar(
          color: AppTheme.grey,
          shape: AutomaticNotchedShape(RoundedRectangleBorder(), CircleBorder()),
          notchMargin: 8,
          child: SizedBox(
            height: 48,
            child: Row(
              children: <Widget>[
                IconButton(
                  iconSize: 48,
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 21,
                        height: 21,
                      ),
                    ],
                  ),
                  onPressed: () => print('Tap!'),
                ),
                Spacer(),
                _actionItems,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _actionItems {
    return Consumer<EmailModel>(
      builder: (BuildContext context, EmailModel model, Widget child) {
        final bool showSecond = model.currentlySelectedEmailId >= 0;

        return AnimatedCrossFade(
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn,
          sizeCurve: Curves.fastOutSlowIn,
          firstChild: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => print('Tap!'),
          ),
          secondChild: showSecond
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/images/ic_important.png', width: 28),
                      onPressed: () => print('Tap!'),
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/ic_more.png', width: 28),
                      onPressed: () => print('Tap!'),
                    ),
                  ],
                )
              : const SizedBox(),
          crossFadeState: showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 450),
        );
      },
    );
  }

  Widget get _fab {
    return AnimatedBuilder(
      animation: ModalRoute.of(context).animation,
      child: Consumer<EmailModel>(
        builder: (BuildContext context, EmailModel model, Widget child) {
          final bool showEditAsAction = model.currentlySelectedEmailId == -1;

          return FloatingActionButton(
            key: _fabKey,
            child: SizedBox(
              width: 24,
              height: 24,
              child: FlareActor(
                'assets/flare/edit_reply.flr',
                animation: showEditAsAction ? 'ReplyToEdit' : 'EditToReply',
              ),
            ),
            backgroundColor: AppTheme.orange,
            onPressed: () => Navigator.of(context).push<void>(
              EditorPage.route(context, _fabKey),
            ),
          );
        },
      ),
      builder: (BuildContext context, Widget fab) {
        final Animation<double> animation = ModalRoute.of(context).animation;
        return SizedBox(
          width: 54 * animation.value,
          height: 54 * animation.value,
          child: fab,
        );
      },
    );
  }

  Future<bool> _willPopCallback() async {
    if (_navigatorKey.currentState.canPop()) {
      _navigatorKey.currentState.pop();
      Provider.of<EmailModel>(context).currentlySelectedEmailId = -1;
      return false;
    }
    return true;
  }
}
