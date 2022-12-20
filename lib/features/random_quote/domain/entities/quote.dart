import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String id;
  final String content;
  final String author;
  final List<String> tags;
  final String authorSlug;
  final int length;
  final DateTime dateAdded;
  final DateTime dateModified;

  const Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  });

  @override
  List<Object?> get props =>
      [id, content, author, tags, authorSlug, length, dateAdded, dateModified];
}
