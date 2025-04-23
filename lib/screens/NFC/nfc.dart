import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: NFCReaderScreen(),
    );
  }
}


class NFCReaderScreen extends StatefulWidget {
  const NFCReaderScreen({super.key});

  @override
  State<NFCReaderScreen> createState() => _NFCReaderScreenState();
}

class _NFCReaderScreenState extends State<NFCReaderScreen> {
  String _nfcData = 'Tap NFC card to read...';

  @override
  void initState() {
    super.initState();
    _checkNFCAvailability();
  }

  Future<void> _checkNFCAvailability() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      setState(() {
        _nfcData = '❌ NFC is not available on this device.';
      });
    } else {
      _startNFCSession();
    }
  }

  void _startNFCSession() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      print("✅ NFC tag discovered: $tag");

      try {
        // Read tag ID or content (works for most types)
        final identifier = tag.data['nfca']?['identifier'] ??
            tag.data['ndef']?['identifier'] ??
            tag.data['mifareclassic']?['identifier'];

        if (identifier != null) {
          String uid = identifier.toString();
          print("🆔 Card UID: $uid");

          setState(() {
            _nfcData = "📲 Card UID: $uid";
          });
        } else {
          print("⚠ Tag has no identifier");
          setState(() {
            _nfcData = "⚠ Could not read UID.";
          });
        }

        await NfcManager.instance.stopSession();
      } catch (e) {
        print("❌ Exception: $e");
        await NfcManager.instance.stopSession(errorMessage: "Read failed");
        setState(() {
          _nfcData = "❌ Failed to read tag.";
        });
      }
    });
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Reader'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _nfcData,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}