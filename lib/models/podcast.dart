  class Podcast {
    String? id; 
    String title;
    String owner;
    String category;

    Podcast({
      this.id,
      required this.title,
      required this.owner,
      required this.category,
    });

    Map<String, dynamic> toMap() {
      return {
        'title': title,
        'owner': owner,
        'category': category,
      };
    }

    factory Podcast.fromMap(String id, Map<String, dynamic> data) {
      return Podcast(
        id: id,
        title: data['title'],
        owner: data['owner'],
        category: data['category'],
      );
    }
  }