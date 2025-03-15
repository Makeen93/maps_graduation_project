import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('selectLanguage'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('english'.tr),
            onTap: () {
              // Provider.of<LanguageProvider>(context, listen: false)
              //     .changeLanguage('en');
              // Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('arabic'.tr),
            onTap: () {
              // Provider.of<LanguageProvider>(context, listen: false)
              //     .changeLanguage('ar');
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
