import 'package:flutter/material.dart';
import 'package:noty/ui/pages/notes/widgets/note_app_bar.dart';
import 'package:noty/ui/pages/settings/widgets/setting_tile_info.dart';
import 'package:noty/utils/themes/decorations.dart';
import '../../../features/connector/connector.dart';

class SettingsPage extends StatefulWidget {
  final Function()? onpress;
  final Connector connector;
  const SettingsPage({
    Key? key,
    this.onpress,
    required this.connector,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // if (mounted) {
    //   UnityAds.load(
    //     placementId: 'Banner_Android',
    //     onComplete: (placementId) => print('Load Complete $placementId'),
    //     onFailed: (placementId, error, message) =>
    //         print('Load Failed $placementId: $error $message'),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Decorations.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            NoteAppBar(
              label: "Settings",
              onpress: widget.onpress,
            ),
            SettingInfo(
              title: "Version",
              des: "1.0.0 Beta",
            ),
          ],
        ),
      ),
    );
  }
}
