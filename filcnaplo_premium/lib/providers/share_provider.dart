import 'package:filcnaplo/api/client.dart';
import 'package:filcnaplo/api/providers/user_provider.dart';
import 'package:filcnaplo/models/settings.dart';
import 'package:filcnaplo/models/shared_theme.dart';
// import 'package:filcnaplo/models/shared_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ShareProvider extends ChangeNotifier {
  final UserProvider _user;

  ShareProvider({
    required UserProvider user,
  }) : _user = user;

  // Future<void> shareTheme({required SharedTheme theme}) async {

  // }
  Future<void> shareCurrentTheme(BuildContext context,
      {bool isPublic = false, bool shareNick = true}) async {
    final SettingsProvider settings = Provider.of<SettingsProvider>(context);

    Map themeJson = {
      'public_id': const Uuid().v4(),
      'is_public': isPublic,
      'nickname': shareNick ? _user.nickname : 'Anonymous',
      'background_color': (settings.customBackgroundColor ??
              SettingsProvider.defaultSettings().customBackgroundColor)
          ?.value,
      'panels_color': (settings.customHighlightColor ??
              SettingsProvider.defaultSettings().customHighlightColor)
          ?.value,
      'accent_color': (settings.customAccentColor ??
              SettingsProvider.defaultSettings().customAccentColor)
          ?.value,
    };

    SharedTheme theme = SharedTheme.fromJson(themeJson);

    FilcAPI.addSharedTheme(theme);
  }
}
