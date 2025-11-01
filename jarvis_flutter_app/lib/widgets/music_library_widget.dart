import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/jarvis_provider.dart';

class MusicLibraryWidget extends StatelessWidget {
  const MusicLibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JarvisProvider>(
      builder: (context, provider, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🎵 Music Library',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, size: 20, color: Colors.grey[600]),
                    onPressed: provider.loadMusicLibrary,
                    tooltip: 'Refresh',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              provider.musicLibrary.isEmpty
                  ? Text(
                      'No songs available',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: provider.musicLibrary.map((song) {
                        return _buildMusicButton(context, song);
                      }).toList(),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMusicButton(BuildContext context, String song) {
    final displayName = song.split(' ')
        .map((word) => word.isNotEmpty 
            ? word[0].toUpperCase() + word.substring(1) 
            : '')
        .join(' ');
    
    return InkWell(
      onTap: () {
        context.read<JarvisProvider>().sendCommand('play $song');
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          displayName,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
