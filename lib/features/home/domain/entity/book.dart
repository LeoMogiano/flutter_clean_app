import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    required this.id,
    required this.title,
    required this.authors,
    this.subtitle,
    this.description,
    this.thumbnailUrl,
    this.pageCount,
    this.averageRating,
    this.categories,
    this.language,
    this.shelf,
  });

  final String id;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? description;
  final String? thumbnailUrl;
  final int? pageCount;
  final double? averageRating;
  final List<String>? categories;
  final String? language;
  final String? shelf;

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    authors,
    description,
    pageCount,
    categories,
    averageRating,
    language,
    shelf,
  ];
}
