import 'package:flutter/widgets.dart';

import 'email.dart';

class EmailModel with ChangeNotifier {

  final List<Email> _emails = <Email>[
    Email("Google Express", "15 minutes ago", "Package shipped!", "Cucumber Mask Facial has shipped!\n\nAttached to this email you can find your invoice.\n\nYou will receive a tracking number in a seperate email from our shipping partner.\n\nThank you for shopping with Phantom cosmetics!", "avatar0.jpg", "me", true, false, false),
    Email("Ali Connors", "25 minutes ago", "Brunch this weekend?", "I’ll be in your neighborhood doing errands on Saturday morning and wanted to ask if you would be up for having brunch at The Cake Facory?\n\nWould love to catch up with you!", "avatar1.jpg", "me", false, false, false),
    Email("Sandra Adams", "6 hrs ago", "Bonjour from Paris", "Here are some great shots from my trip to Paris this summer!", "avatar2.jpg", "Shawn, Melli, me", false, true, false),
    Email("Trevor Hansen", "12 hrs ago", "High school reunion?", "Hi friends, I was at the grocery store on Sunday night... when I ran into Genie Williams! I almost didn't recognize her after 20 years!\n\nAnyway, it turns out she is on the organizing committee for the high school reunion this fall. I don't know if you were planning on going or not, but she could definitely use our help in trying to track down lots of missing alums. If you can make it, we're doing a little phone-tree party at her place next Saturday, hoping that if we can find one person, a few more will emerge. What do you say? Want to see if Drew and Todd can make it too? \n\nTalk soon! Trevor", "avatar3.jpg", "me, Rachel, and Zach", false, false, true),
    Email("Britta Holt", "18 hrs ago", "Recipe to try", "We should make this one day when we do a brunch again. Looks super nice!", "avatar4.jpg", "Shawn, Melli, me", true, false, false),
    Email("Julian Miller", "20 hrs ago", "Meeting you in Berlin!", "Hey there, how are you doing?", "avatar5.jpg", "Shawn, Melli, me", false, false, false),
    Email("Frederik Schweiger", "22 hrs ago", "Reply Material Case Study", "Hey there, great news! Today I have finally published the source code for the Reply Material Design case study I have been working on over the last few weeks.\n\nYoucan find it on my GitHub account. Let me know what you think!\n\nCheers!", "avatar6.jpg", "me", false, false, false),
    Email("Dan Lightfoot", "1 day ago", "Dog Sitting in London", "What's up? I wanted to reach out to you because I though that you may know a trusted dog sitting place in central London?\n\nI have an important meeting with Jay on Friday next week so I need someone who can take care of Jimmy...", "avatar7.jpg", "me", false, false, false),
  ];

  int _currentlySelectedEmailId = -1;

  List<Email> get emails => List<Email>.unmodifiable(_emails);

  void deleteEmail(int id) {
    _emails.removeAt(id);
    notifyListeners();
  }

  int get currentlySelectedEmailId => _currentlySelectedEmailId;

  set currentlySelectedEmailId(int value) {
    _currentlySelectedEmailId = value;
    notifyListeners();
  }

}
