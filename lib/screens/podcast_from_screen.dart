import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast_app/models/podcast.dart';

class PodcastFormScreen extends StatefulWidget {
  final Podcast? podcast;

  PodcastFormScreen({this.podcast});

  @override
  _PodcastFormScreenState createState() => _PodcastFormScreenState();
}

class _PodcastFormScreenState extends State<PodcastFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _ownerController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.podcast?.title ?? '');
    _ownerController = TextEditingController(text: widget.podcast?.owner ?? '');
    _categoryController = TextEditingController(text: widget.podcast?.category ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ownerController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final podcast = Podcast(
        id: widget.podcast?.id,
        title: _titleController.text,
        owner: _ownerController.text,
        category: _categoryController.text,
      );
      final ref = FirebaseFirestore.instance.collection('Podcasts');
      if (widget.podcast == null) {
        // Add new podcast
        ref.add(podcast.toMap());
      } else {
        // Update existing podcast
        ref.doc(podcast.id).update(podcast.toMap());
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.podcast == null ? 'Add Podcast' : 'Edit Podcast'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Podcast Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
                
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _ownerController,
                decoration: InputDecoration(labelText: 'Owner'),
                validator: (value) => value!.isEmpty ? 'Enter an owner' : null,
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Enter a category' : null,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(widget.podcast == null ? 'Add' : 'Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, 
                    ),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}