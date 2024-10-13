class NotesModal {
  String title, content, datetime, category;
  int id;

  NotesModal._(
      {required this.title,
      required this.content,
      required this.datetime,
      required this.category,
      required this.id});

  factory NotesModal(Map json) {
    return NotesModal._(
        title: json['Title'],
        content: json['Content'],
        datetime: json['Datetime'],
        category: json['Category'],
        id: json['Id']);
  }

  Map<String, dynamic> modalToMap(NotesModal notes)
  {
    return {
      'Id':notes.id,
      'Title':notes.title,
      'Content':notes.content,
      'Datetime':notes.datetime,
      'Category':notes.category
    };
  }
}
