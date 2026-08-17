import 'package:url_launcher/url_launcher.dart';

class LauncherService {
  static Future<void> openUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> openEmail(Map<String, String>? data) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: data?['email'] ?? '',
      query: encodeQueryParameters({
        'subject': data?['subject'] ?? '',
        'body': data?['body'] ?? '',
      }),
    );

    if (!await launchUrl(emailUri)) {
      throw 'Could not launch $emailUri';
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  static Future<void> openPhone(String phoneNumber) async {
    final phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (!await launchUrl(phoneUri)) {
      throw 'Could not launch $phoneUri';
    }
  }
}
