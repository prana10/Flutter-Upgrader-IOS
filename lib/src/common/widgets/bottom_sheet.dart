import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/path.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
    required this.packageInfo,
    required this.appstoreLink,
    required this.versionUpgrader,
  });

  final PackageInfo packageInfo;
  final Uri appstoreLink;
  final VersionUpgrader versionUpgrader;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Wrap(
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context: context),
              const SizedBox(height: 24),
              _body(),
              const SizedBox(height: 24),
              _footer(context: context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  // header widget
  // untuk menampilkan appstore dengan logo nya dan tombol close
  Widget _header({
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/ic_appstore.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text('App Store'),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Update available',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'to use this app, you need to update it to the latest version',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Image.asset(
              'assets/ic_appstore.png',
              width: 48,
              height: 48,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    packageInfo.appName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Version ${versionUpgrader.version}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _footer({
    required BuildContext context,
  }) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlineButton(
            text: "Cancel",
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: 'Update',
            onTap: () {
              // taruh launcher url yang langsung ngarah ke appstore
              // https://apps.apple.com/id/app/youtube/id544007664?l=id
              customLaunchUrl(appstoreLink);
            },
          ),
        ),
      ],
    );
  }
}
