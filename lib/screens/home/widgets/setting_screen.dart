import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pocx/db/transaction/transaction_db.dart';
import 'package:pocx/screens/home/widgets/about_screen.dart';
import 'package:pocx/screens/home/widgets/reminder_screen.dart';
import 'package:pocx/screens/home/widgets/search_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void listNotifications() => NotificationApi.onNotifications;

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    listNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.red,
        ),
        title: RichText(
          text: const TextSpan(
            text: 'S',
            style: TextStyle(
              fontSize: 23,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'ettings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ) 
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const ListTile(
              leading: Text('Notification'),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.red,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: RichText(
                            text: const TextSpan(
                              text: 'R',
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'eminder',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          content: const Text(
                              'Please confirm that you want to on reminder at 8.00pm.'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  return Navigator.of(context).pop();
                                },
                                child: const Text('CANCEL')),
                            TextButton(
                                onPressed: () {
                                  reminderFunction();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'))
                          ],
                        ));
              },
              title: const Text('Reminder'),
            ),
            const Divider(
              thickness: 1,
            ),
            const ListTile(
              leading: Text('communicate'),
            ),
            ListTile(
              leading: const Icon(
                Icons.mail_outline,
                color: Colors.red,
              ),
              onTap: () async {
                _url();
              },
              title: const Text('Contact us'),
            ),
            ListTile(
              leading: const Icon(
                Icons.feedback_outlined,
                color: Colors.red,
              ),
              title: const Text('Feedback'),
              onTap: () async {
                _feedback();
              },
            ),
            const Divider(
              thickness: 1,
            ),
            const ListTile(
              leading: Text('Info'),
            ),
            const ListTile(
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: Colors.red,
              ),
              title: Text('Privacy policy'),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              title: const Text('Reset app'),
              onTap: () {
               showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: RichText(
                                text: const TextSpan(
                                  text: 'R',
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'eset',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              content: const Text(
                                  'Are you sure you want to reset your app?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('CANCEL')),
                                TextButton(
                                    onPressed: () {
                                      searchNotifier.value.clear();
                                      TransactionDb.instance.appReset(context);
                                     
                                    },
                                    child: const Text('OK'))
                              ],
                            ),
                          );
              },
            ),
            ListTile(
              onTap: () async {
                await Share.share('PocX');
              },
              leading: const Icon(
                Icons.share_outlined,
                color: Colors.red,
              ),
              title: const Text('Share'),
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.red,
              ),
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ));
              },
            ),
            const SizedBox(
              height: 0,
            ),
            const Center(
              child: Text(
                'v.1.0.0',
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  reminderFunction() async {
    await NotificationApi.showScheduledNotification(
      title: 'Dinner',
      body: 'Today at 6 PM',
      payload: 'dinner _6pm',
      scheduledDate: DateTime.now().add(
        const Duration(seconds: 12),
      ),
    );
  }

  Future<void> _url() async {
    String urls = 'mailto:itsmesauravr@gmail.com';
    final parseurl = Uri.parse(urls);
    try {
      if (!await launchUrl(parseurl)) {
        throw 'could not launch';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _feedback() async {
    String urls = 'mailto:itsmesauravr@gmail.com';
    final parseurl = Uri.parse(urls);
    try {
      if (!await launchUrl(parseurl)) {
        throw 'could not launch';
      }
    } catch (e) {
      log(e.toString());
    }
  }
 
}
