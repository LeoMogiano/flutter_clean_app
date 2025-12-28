import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home/domain/entity/book.dart';
import 'package:my_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tapCount = 0;
  bool _showMessage = false;

  void _handleTap() {
    setState(() {
      _tapCount++;
      if (_tapCount >= 10) {
        _showMessage = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final blocState = context.watch<HomeBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _handleTap,
          child: const Text('XD'),
        ),
      ),
      body: Center(
        child: _showMessage
            ? const Text('Nirvana te amo')
            : switch (blocState) {
                HomeInitial() => const Text('Welcome to the Book App!'),
                HomeLoading() => const CircularProgressIndicator(),
                HomeLoaded(:final books) => BookList(books),
                _ => const Text('Unknown state'),
              },
      ),
    );
  }
}

class BookList extends StatelessWidget {
  const BookList(this.books, {super.key});
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final book = books[index];
              return ListTile(
                key: ValueKey(book.id),
                title: Text(book.title),
                subtitle: book.thumbnailUrl != null
                    ? SizedBox(
                        width: 20.w,
                        height: 30.h,
                        child: CachedNetworkImage(
                          imageUrl: book.thumbnailUrl!,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      )
                    : null,
              );
            },
            childCount: books.length,
          ),
        ),
      ],
    );
  }
}
