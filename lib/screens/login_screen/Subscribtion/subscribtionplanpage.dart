import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPlansPage extends StatelessWidget {
  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('You are redirecting to ths page because, You do not have any Subscription Plan,Yet! '),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(" To get the more details about Our Subscription plan which is  sutable for you",style: TextStyle(fontSize:18),),
          SizedBox(height: 12 ),
          Text(" Click on the below given button ",style: TextStyle(fontSize:30),),
          SizedBox(height: 12,),
          Center(
            child: ElevatedButton(
              onPressed: _launchSubscriptionUrl,
              child: const Text('Subscription Plans'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchSubscriptionUrl() async {
    final url = Uri.parse('https://intervein.dprofiz.com/Rfid_api/Payment/payment.html');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}