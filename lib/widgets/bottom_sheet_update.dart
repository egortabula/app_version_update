import 'package:app_version_update/data/models/app_version_result.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// ```AppVersionUpdate.showBottomSheetUpdate()``` AlertDialog widget
// ignore: must_be_immutable
class BottomSheetUpdateVersion extends Container {
  final AppVersionResult? appVersionResult;
  final String? title;
  final bool mandatory;
  final Widget? content;
  BottomSheetUpdateVersion(
      {this.appVersionResult,
      this.content,
      this.mandatory = false,
      this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                content ?? const SizedBox.shrink(),
                mandatory && content == null
                    ? const Text(
                        'Пожалуйста обновите приложение до последней версии',
                      )
                    : !mandatory && content == null
                        ? const Text(
                            'Доступно обновление, желаете обновиться?',
                          )
                        : const SizedBox.shrink(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mandatory
                    ? const SizedBox.shrink()
                    : MaterialButton(
                        minWidth: 140.0,
                        onPressed: () =>
                            Navigator.pop(context, (route) => false),
                        color: const Color(0xffDBD2CA),
                        child: const Text(
                          'Обновить позже',
                          style: TextStyle(color: Color(0xff2B2C34)),
                        ),
                      ),
                MaterialButton(
                  minWidth: 140.0,
                  onPressed: () async => await launchUrl(
                      Uri.parse(appVersionResult!.storeUrl!),
                      mode: LaunchMode.externalApplication),
                  color: const Color(0xffE7623F),
                  child: const Text(
                    'Обновить',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
