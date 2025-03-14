import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast_app/models/podcast.dart';
import 'package:podcast_app/screens/podcast_from_screen.dart';

class PodcastListScreen extends StatelessWidget {
  final CollectionReference podcastsRef =
      FirebaseFirestore.instance.collection('Podcasts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podcast List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            
            Navigator.pushReplacementNamed(context, '/splash');
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: podcastsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No podcasts available. Add one!',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            );
          }
          final podcasts = snapshot.data!.docs
              .map((doc) => Podcast.fromMap(doc.id, doc.data() as Map<String, dynamic>))
              .toList();
          return ListView.builder(
            itemCount: podcasts.length,
            itemBuilder: (context, index) {
              final podcast = podcasts[index];
              return ListTile(
                title: Text(podcast.title),
                subtitle: Text(podcast.category),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PodcastFormScreen(podcast: podcast),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => podcastsRef.doc(podcast.id).delete(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PodcastFormScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}