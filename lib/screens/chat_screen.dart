import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat List', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft, // Changed from centerRight to centerLeft
              child: Text(
                'All Message',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(
                            userName: 'Person $index',
                            userImage: 'assets/images/user1.png',
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/profile.png'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Person $index',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Last message preview from the chat...',
                                    style: TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  '12:34 PM',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                SizedBox(height: 4),
                                Icon(Icons.check_circle, size: 18, color: Colors.green),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String userName;
  final String userImage;

  const ChatDetailScreen({
    super.key,
    required this.userName,
    required this.userImage,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    // Sample messages to show the layout

    {
      'text': 'What about you?',
      'isMe': true,
      'time': '2:31 PM',
      'senderName': 'You',
      'senderImage': 'assets/images/profile.png',
    },
    {
      'text': 'I\'m doing great, thanks!',
      'isMe': true,
      'time': '2:31 PM',
      'senderName': 'You',
      'senderImage': 'assets/images/profile.png',
    },
    {
      'text': 'Hey! How are you?',
      'isMe': false,
      'time': '2:30 PM',
      'senderName': 'Ali Benali',
      'senderImage': 'assets/images/user1.png',
    },


  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {
          'text': text,
          'isMe': true,
          'time': TimeOfDay.now().format(context),
          'senderName': 'You',
          'senderImage': 'assets/images/profile.png',
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF586C7C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // Changed to '<' style arrow
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.userName,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Center the title
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {
              // Add call functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Latest at bottom
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['isMe'] as bool;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe) ...[
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(message['senderImage']),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            if (!isMe)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  message['senderName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? const Color(0xFF586C7C)
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                message['text'],
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              message['time'],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(message['senderImage']),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: const Color(0xFF586C7C),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}