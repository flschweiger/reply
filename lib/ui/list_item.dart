import 'package:flutter/material.dart';
import 'package:reply/details_page.dart';
import 'package:reply/model/email.dart';
import 'package:reply/styling.dart';
import 'package:reply/ui/rounded_avatar.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, this.id, this.email, this.onDeleted}) : super(key: key);

  final int id;
  final Email email;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(email),
      dismissThresholds: const {
        DismissDirection.startToEnd: 1,
        DismissDirection.endToStart: 0.4,
      },
      onDismissed: (DismissDirection direction) {
        switch (direction) {
          case DismissDirection.endToStart:
            onDeleted();
            break;
          case DismissDirection.startToEnd:
            // TODO: Handle this case.
            break;
          default:
          // Do not do anything
        }
      },
      background: Container(
        decoration: BoxDecoration(
          color: AppTheme.orange,
          border: Border.all(color: AppTheme.notWhite, width: 2),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Image.asset(
          'assets/images/ic_star.png',
          width: 36,
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: AppTheme.dismissibleBackground,
          border: Border.all(color: AppTheme.notWhite, width: 2),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Image.asset(
          'assets/images/ic_trash.png',
          width: 36,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          color: AppTheme.nearlyWhite,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _header,
                  if (!email.isRead) const SizedBox(height: 14),
                  if (!email.isRead) _emailPreview,
                ],
              ),
            ),
            onTap: () => Navigator.of(context).push<void>(DetailsPage.route(context, id, email)),
          ),
        ),
      ),
    );
  }

  Widget get _header {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${email.sender} — ${email.time}',
                style: AppTheme.caption.copyWith(color: email.isRead ? AppTheme.deactivatedText : AppTheme.darkText),
              ),
              const SizedBox(height: 2),
              Text(
                email.subject,
                style: email.containsPictures
                    ? AppTheme.headline
                    : AppTheme.title.copyWith(color: email.isRead ? AppTheme.deactivatedText : AppTheme.darkText),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Hero(tag: email.subject, child: RoundedAvatar(image: 'assets/images/${email.avatar}')),
      ],
    );
  }

  Widget get _emailPreview {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            if (email.hasAttachment)
              const Padding(
                padding: EdgeInsets.only(right: 18),
                child: Icon(
                  Icons.attachment,
                  size: 24,
                  color: Color(0xFF4A6572),
                ),
              ),
            Flexible(
              child: Text(
                email.message,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTheme.subtitle,
              ),
            ),
          ],
        ),
        if (email.containsPictures) ..._miniGallery,
      ],
    );
  }

  List<Widget> get _miniGallery {
    return <Widget>[
      const SizedBox(height: 21),
      SizedBox(
        width: double.infinity,
        height: 96,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List<Widget>.generate(
            5,
            (int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Image.asset(
                  'assets/images/photo$index.jpg',
                ),
              );
            },
          ),
        ),
      ),
    ];
  }
}
