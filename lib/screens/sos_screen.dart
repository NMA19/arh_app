import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  bool _showTawkChat = false;
  bool _isEmergencyMode = false;
  bool _isTyping = false;
  Position? _currentLocation;

  late WebViewController _webViewController;
  late AnimationController _pulseController;
  late AnimationController _emergencyController;
  late Animation<double> _pulseAnimation;
  late Animation<Color?> _emergencyColorAnimation;

  // Emergency contacts
  final List<EmergencyContact> _emergencyContacts = [
    EmergencyContact(name: "Emergency Services", number: "911", icon: Icons.local_hospital),
    EmergencyContact(name: "Police", number: "911", icon: Icons.local_police),
    EmergencyContact(name: "Fire Department", number: "911", icon: Icons.local_fire_department),
    EmergencyContact(name: "Poison Control", number: "1-800-222-1222", icon: Icons.warning),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeWebView();
    _getCurrentLocation();
    _addWelcomeMessage();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _emergencyController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _emergencyColorAnimation = ColorTween(
      begin: Colors.red[600],
      end: Colors.red[900],
    ).animate(_emergencyController);
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          // Handle page loading
        },
        onPageFinished: (String url) {
          // Inject emergency context
          _webViewController.runJavaScript('''
            if (typeof Tawk_API !== 'undefined' && Tawk_API.isVisitorEngaged) {
              Tawk_API.addEvent('Emergency Context', {
                'userType': 'SOS Emergency',
                'location': '${_currentLocation?.latitude ?? "Unknown"}, ${_currentLocation?.longitude ?? "Unknown"}',
                'timestamp': '${DateTime.now().toIso8601String()}',
                'appVersion': '1.0.0'
              });
            }
          ''');
        },
      ))
      ..loadHtmlString(_getTawkHtml());
  }

  Future<void> _getCurrentLocation() async {
    try {
      final permission = await Permission.location.request();
      if (permission.isGranted) {
        _currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {});
      }
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(ChatMessage(
        text: "🆘 Welcome to Emergency Support! I'm here to help you 24/7.\n\n"
            "• For life-threatening emergencies, call 911 immediately\n"
            "• Use 'Live Support' for real-time assistance\n"
            "• I can help with emergency contacts and guidance\n\n"
            "How can I assist you today?",
        isUser: false,
        timestamp: DateTime.now(),
        messageType: MessageType.system,
      ));
    });
  }

  String _getTawkHtml() {
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <title>SOS Emergency Live Support</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            html, body {
                height: 100%;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background-color: #ffffff;
                overflow: hidden;
            }
            .container {
                height: 100vh;
                display: flex;
                flex-direction: column;
                background: linear-gradient(135deg, #d32f2f 0%, #b71c1c 100%);
            }
            .header {
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(15px);
                padding: 20px;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.3);
                box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            }
            .header h2 {
                color: white;
                font-size: 20px;
                font-weight: 700;
                text-shadow: 0 2px 4px rgba(0,0,0,0.3);
                margin-bottom: 5px;
            }
            .status {
                color: rgba(255,255,255,0.9);
                font-size: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
            }
            .status-dot {
                width: 8px;
                height: 8px;
                background: #4caf50;
                border-radius: 50%;
                animation: pulse 2s infinite;
            }
            @keyframes pulse {
                0% { opacity: 1; transform: scale(1); }
                50% { opacity: 0.7; transform: scale(1.2); }
                100% { opacity: 1; transform: scale(1); }
            }
            .chat-container {
                flex: 1;
                position: relative;
                background: white;
                margin: 15px;
                border-radius: 16px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.15);
                overflow: hidden;
            }
            .loading {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                text-align: center;
                z-index: 10;
                background: rgba(255,255,255,0.95);
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            }
            .spinner {
                width: 50px;
                height: 50px;
                border: 4px solid #f3f3f3;
                border-top: 4px solid #d32f2f;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin: 0 auto 20px;
            }
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
            .loading p {
                color: #666;
                font-size: 16px;
                font-weight: 500;
            }
            .emergency-notice {
                position: fixed;
                bottom: 20px;
                left: 20px;
                right: 20px;
                background: rgba(211, 47, 47, 0.95);
                color: white;
                padding: 16px;
                border-radius: 12px;
                text-align: center;
                font-size: 13px;
                font-weight: 600;
                z-index: 1000;
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 20px rgba(0,0,0,0.3);
                border: 1px solid rgba(255,255,255,0.2);
            }
            #tawk-bubble-container { display: none !important; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h2>🆘 Emergency Live Support</h2>
                <div class="status">
                    <div class="status-dot"></div>
                    <span>Connected • Priority Support</span>
                </div>
            </div>
            <div class="chat-container">
                <div class="loading" id="loadingIndicator">
                    <div class="spinner"></div>
                    <p>Connecting to emergency support agent...</p>
                    <p style="font-size: 12px; color: #999; margin-top: 10px;">Please wait, you'll be connected shortly</p>
                </div>
            </div>
        </div>
        
        <div class="emergency-notice">
            ⚠️ Life-threatening emergency? Call 911 immediately
        </div>

        <script type="text/javascript">
        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
        
        Tawk_API.customStyle = {
            visibility : {
                desktop : { position : 'embedded', xOffset : 0, yOffset : 0 },
                mobile : { position : 'embedded', xOffset : 0, yOffset : 0 }
            }
        };

        Tawk_API.visitor = {
            name : 'Emergency User',
            email : 'emergency@sos-app.help'
        };

        Tawk_API.onLoad = function(){
            document.getElementById('loadingIndicator').style.display = 'none';
            setTimeout(function() {
                if (typeof Tawk_API.addEvent === 'function') {
                    Tawk_API.addEvent('SOS Emergency Session', {
                        'source': 'SOS Mobile App',
                        'priority': 'EMERGENCY',
                        'timestamp': new Date().toISOString(),
                        'sessionType': 'Emergency Support'
                    });
                }
            }, 1000);
        };

        (function(){
        var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
        s1.async=true;
        s1.src='https://embed.tawk.to/687a798b487057192063a974/1j0f6li4q';
        s1.charset='UTF-8';
        s1.setAttribute('crossorigin','*');
        s0.parentNode.insertBefore(s1,s0);
        })();
        </script>
    </body>
    </html>
    ''';
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    // Simulate bot typing and response
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          text: _getBotResponse(text),
          isUser: false,
          timestamp: DateTime.now(),
          messageType: _getMessageType(text),
        ));
      });
      _scrollToBottom();
    });
  }

  MessageType _getMessageType(String input) {
    final lowercaseInput = input.toLowerCase();
    if (lowercaseInput.contains('emergency') ||
        lowercaseInput.contains('urgent') ||
        lowercaseInput.contains('help')) {
      return MessageType.urgent;
    }
    return MessageType.normal;
  }

  String _getBotResponse(String userInput) {
    final lowercaseInput = userInput.toLowerCase();

    if (lowercaseInput.contains('emergency') || lowercaseInput.contains('urgent')) {
      _triggerEmergencyMode();
      return '🚨 EMERGENCY DETECTED!\n\n'
          'I\'m escalating your case to live support immediately.\n\n'
          '• Tap "LIVE SUPPORT" below for instant help\n'
          '• Your location: ${_getLocationString()}\n'
          '• Emergency contacts are available in the contacts tab\n\n'
          'If this is life-threatening, call 911 NOW!';
    } else if (lowercaseInput.contains('location')) {
      return '📍 Your current location:\n${_getLocationString()}\n\n'
          'This information will be shared with emergency responders if needed.';
    } else if (lowercaseInput.contains('contact') || lowercaseInput.contains('number')) {
      return '📞 Emergency Contacts:\n\n'
          '• Emergency Services: 911\n'
          '• Poison Control: 1-800-222-1222\n'
          '• National Suicide Prevention: 988\n\n'
          'Tap the contacts button for quick dial options.';
    } else if (lowercaseInput.contains('help')) {
      return '🤝 I\'m here to help! Here\'s what I can do:\n\n'
          '• Connect you to live emergency support\n'
          '• Provide emergency contact numbers\n'
          '• Share your location with responders\n'
          '• Guide you through emergency procedures\n\n'
          'What specific help do you need?';
    } else if (lowercaseInput.contains('medical') || lowercaseInput.contains('health')) {
      return '🏥 For medical emergencies:\n\n'
          '• Call 911 for immediate medical help\n'
          '• Use live support for medical guidance\n'
          '• Poison emergencies: 1-800-222-1222\n\n'
          'Never delay calling emergency services for serious medical issues!';
    } else {
      return 'I understand you need assistance. For the fastest help:\n\n'
          '• Use "Live Support" for immediate human assistance\n'
          '• Type "emergency" for urgent situations\n'
          '• Ask about "contacts" for emergency numbers\n\n'
          'How else can I help you today?';
    }
  }

  String _getLocationString() {
    if (_currentLocation != null) {
      return 'Lat: ${_currentLocation!.latitude.toStringAsFixed(4)}, '
          'Lng: ${_currentLocation!.longitude.toStringAsFixed(4)}';
    }
    return 'Location not available';
  }

  void _triggerEmergencyMode() {
    if (!_isEmergencyMode) {
      setState(() {
        _isEmergencyMode = true;
      });
      HapticFeedback.heavyImpact();
      _emergencyController.repeat(reverse: true);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _makeEmergencyCall(String number) async {
    final url = 'tel:$number';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $number')),
        );
      }
    }
  }

  void _showEmergencyContacts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Emergency Contacts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ..._emergencyContacts.map((contact) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[100],
                child: Icon(contact.icon, color: Colors.red[700]),
              ),
              title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(contact.number),
              trailing: IconButton(
                icon: const Icon(Icons.phone, color: Colors.green),
                onPressed: () => _makeEmergencyCall(contact.number),
              ),
              onTap: () => _makeEmergencyCall(contact.number),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _emergencyColorAnimation,
          builder: (context, child) => Text(
            'SOS Emergency Support',
            style: TextStyle(
              color: _isEmergencyMode ? _emergencyColorAnimation.value : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: _isEmergencyMode ? Colors.red[800] : Colors.red[600],
        elevation: _isEmergencyMode ? 8 : 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.contacts_outlined),
            onPressed: _showEmergencyContacts,
            tooltip: 'Emergency Contacts',
          ),
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) => Transform.scale(
              scale: _showTawkChat ? 1.0 : _pulseAnimation.value,
              child: IconButton(
                icon: Icon(_showTawkChat ? Icons.chat_bubble : Icons.support_agent),
                onPressed: () {
                  setState(() {
                    _showTawkChat = !_showTawkChat;
                  });
                },
                tooltip: _showTawkChat ? 'Back to Bot Chat' : 'Live Support',
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _showTawkChat ? _buildTawkChatView() : _buildBotChatView(),
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) => Transform.scale(
          scale: _isEmergencyMode ? _pulseAnimation.value : 1.0,
          child: FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _showTawkChat = true;
              });
              if (_isEmergencyMode) {
                HapticFeedback.heavyImpact();
              }
            },
            backgroundColor: _isEmergencyMode ? Colors.red[800] : Colors.red[600],
            icon: const Icon(Icons.support_agent, color: Colors.white),
            label: Text(
              _isEmergencyMode ? 'EMERGENCY SUPPORT' : 'LIVE SUPPORT',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTawkChatView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red[50]!, Colors.red[100]!],
            ),
            border: Border(bottom: BorderSide(color: Colors.red[200]!)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.live_help, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Emergency Support',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Connected to emergency support agent',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _showTawkChat = false;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: WebViewWidget(controller: _webViewController),
        ),
      ],
    );
  }

  Widget _buildBotChatView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[50]!, Colors.blue[100]!],
            ),
            border: Border(bottom: BorderSide(color: Colors.blue[200]!)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Emergency Assistant',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Available 24/7 • For emergencies, use Live Support',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length + (_isTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length && _isTyping) {
                return _buildTypingIndicator();
              }
              return _buildMessage(_messages[index]);
            },
          ),
        ),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? Colors.blue[600]
              : message.messageType == MessageType.urgent
              ? Colors.red[50]
              : message.messageType == MessageType.system
              ? Colors.grey[100]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: message.messageType == MessageType.urgent
              ? Border.all(color: Colors.red[300]!, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.messageType == MessageType.urgent) ...[
              Row(
                children: [
                  Icon(Icons.warning, color: Colors.red[700], size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'URGENT',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message.text,
              style: TextStyle(
                fontSize: 15,
                color: message.isUser ? Colors.white : Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.timestamp),
              style: TextStyle(
                fontSize: 11,
                color: message.isUser
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Assistant is typing'),
            const SizedBox(width: 8),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Describe your emergency or ask for help...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onSubmitted: (_) => _sendMessage(),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _pulseController.dispose();
    _emergencyController.dispose();
    super.dispose();
  }
}

// Data models
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final MessageType messageType;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.messageType = MessageType.normal,
  });
}

class EmergencyContact {
  final String name;
  final String number;
  final IconData icon;

  EmergencyContact({
    required this.name,
    required this.number,
    required this.icon,
  });
}

enum MessageType {
  normal,
  urgent,
  system,
}