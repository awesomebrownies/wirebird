import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Server extends StatefulWidget {
  Server({super.key});

  @override
  State<Server> createState() => _ServerState();

  static Future<String?> getSavedConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('server_config');
  }
}

class _ServerState extends State<Server> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }


  // Method to load text from SharedPreferences
  Future<void> _loadSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    final savedText = prefs.getString('server_config') ?? ''; // Default empty text
    setState(() {
      _textEditingController.text = savedText;
    });
  }

  // Method to save text into SharedPreferences
  Future<void> _saveText() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server_config', _textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Text("Wireguard Server Configuration"),
          TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 15,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter server configuration here",
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              await _saveText(); // Save the text when the button is pressed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Configuration Saved!")),
              );
            },
            child: const Text("Save Configuration"),
          ),
        ],
      );
  }
}