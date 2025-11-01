import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/jarvis_provider.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  final List<Map<String, String>> quickActions = const [
    {'label': '📺 YouTube', 'command': 'open youtube'},
    {'label': '🔍 Google', 'command': 'open google'},
    {'label': '📧 Gmail', 'command': 'open gmail'},
    {'label': '💻 GitHub', 'command': 'open github'},
    {'label': '💼 LinkedIn', 'command': 'open linkedin'},
    {'label': '🤖 ChatGPT', 'command': 'open chatgpt'},
    {'label': '📰 News', 'command': 'news'},
    {'label': '✅ ClickUp', 'command': 'open clickup'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚡ Quick Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: quickActions.map((action) {
              return _buildActionButton(
                context,
                action['label']!,
                action['command']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, String command) {
    return InkWell(
      onTap: () {
        context.read<JarvisProvider>().sendCommand(command);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
