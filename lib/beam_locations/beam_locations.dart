import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import '../main_layout.dart';
import '../provider/auth_provider.dart';
import '../screens/article_details_screen.dart';
import '../screens/articles_screen.dart';
import '../screens/book_details_screen.dart';
import '../screens/books_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/services_screen.dart';
import '../screens/task_screen.dart';

// HomeLocation
class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/home'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('home'),
        title: 'Home',
        child: MainLayout(
          currentIndex: 1,
          child: HomeScreen(),
        ),
      ),
    ];
  }
}

class ServicesLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/services'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('services'),
        title: 'Services',
        child: MainLayout(
          currentIndex: 1,
          child: ServicesScreen(),
        ),
      ),
    ];
  }
}

class TaskLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/task'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('task'),
        title: 'Task',
        child: MainLayout(
          currentIndex: 1,
          child: TaskScreen(),
        ),
      ),
    ];
  }
}

class ProfileLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/profile'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('profile'),
        title: 'Profile',
        child: MainLayout(
          currentIndex: 0,
          child: Center(
            child: Text('Profile Page'),
          ),
        ),
      ),
    ];
  }
}

class SettingsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/settings'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('settings'),
        title: 'Settings',
        child: MainLayout(
          currentIndex: 2,
          child: Center(child: Text('Settings Page')),
        ),
      ),
    ];
  }
}

class BooksLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/books/:bookId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('books'),
          title: 'Books',
          type: BeamPageType.noTransition,
          child: MainLayout(
            currentIndex: 1,
            child: BooksScreen(),
          ),
        ),
        if (state.pathParameters.containsKey('bookId'))
          BeamPage(
            key: ValueKey('book-${state.pathParameters['bookId']}'),
            title: books.firstWhere((book) =>
                book['id'] == state.pathParameters['bookId'])['title'],
            child: MainLayout(
              currentIndex: 1,
              child: BookDetailsScreen(
                book: books.firstWhere(
                    (book) => book['id'] == state.pathParameters['bookId']),
              ),
            ),
          ),
      ];
}

class ArticlesLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/articles/:articleId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('articles'),
          title: 'Articles',
          type: BeamPageType.noTransition,
          child: MainLayout(
            currentIndex: 1,
            child: ArticlesScreen(),
          ),
        ),
        if (state.pathParameters.containsKey('articleId'))
          BeamPage(
            key: ValueKey('articles-${state.pathParameters['articleId']}'),
            title: articles.firstWhere((article) =>
                article['id'] == state.pathParameters['articleId'])['title'],
            child: MainLayout(
              currentIndex: 1,
              child: ArticleDetailsScreen(
                article: articles.firstWhere((article) =>
                    article['id'] == state.pathParameters['articleId']),
              ),
            ),
          ),
      ];
}

class AuthLocation extends BeamLocation<BeamState> {
  final AuthNotifier authNotifier;
  AuthLocation({
    required this.authNotifier,
  });

  @override
  List<String> get pathPatterns => ['/login', '/logout'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    if (state.uri.path == '/logout') {
      authNotifier.logout();
    }

    return [
      BeamPage(
        key: const ValueKey('login'),
        title: 'Login',
        child: LoginScreen(),
      ),
    ];
  }
}
