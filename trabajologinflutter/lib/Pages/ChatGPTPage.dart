import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trabajologinflutter/Modelos/Cliente.dart';

class ChatGPTPage extends StatefulWidget {
  final Cliente cliente;

  ChatGPTPage({required this.cliente});

  @override
  _ChatGPTPageState createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  Future<void> _sendMessage(String message) async {
    setState(() {
      _isLoading = true;
      _messages.add({"role": "user", "content": message});
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'sk-proj-Lc1ghB2yff5JEQIUVNpeT3BlbkFJdaTEDpBDG58KKcWNmH0o',
        },
        body: json.encode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "Eres un asistente de ChatGPT."},
            ..._messages,
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String reply = data['choices'][0]['message']['content'];

        setState(() {
          _messages.add({"role": "assistant", "content": reply});
        });
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          _messages.add({"role": "assistant", "content": "Error: No se pudo obtener respuesta de ChatGPT."});
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _messages.add({"role": "assistant", "content": "Error: Ocurrió un problema."});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(
                    message['content']!,
                    style: TextStyle(
                      color: message['role'] == 'user' ? Colors.blue : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
