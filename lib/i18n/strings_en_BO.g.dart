///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEnBo with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEnBo({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.enBo,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en-BO>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEnBo _root = this; // ignore: unused_field

	@override 
	TranslationsEnBo $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEnBo(meta: meta ?? this.$meta);

	// Translations
	@override String get appTitle => 'My Flutter App';
	@override late final _TranslationsLoginEnBo login = _TranslationsLoginEnBo._(_root);
	@override late final _TranslationsHomeEnBo home = _TranslationsHomeEnBo._(_root);
}

// Path: login
class _TranslationsLoginEnBo implements TranslationsLoginEn {
	_TranslationsLoginEnBo._(this._root);

	final TranslationsEnBo _root; // ignore: unused_field

	// Translations
	@override String get title => 'Login';
	@override String get email => 'Email';
	@override String get password => 'Password';
	@override String get button => 'Sign In';
}

// Path: home
class _TranslationsHomeEnBo implements TranslationsHomeEn {
	_TranslationsHomeEnBo._(this._root);

	final TranslationsEnBo _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Welcome, {name}!';
}

/// The flat map containing all translations for locale <en-BO>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEnBo {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appTitle' => 'My Flutter App',
			'login.title' => 'Login',
			'login.email' => 'Email',
			'login.password' => 'Password',
			'login.button' => 'Sign In',
			'home.welcome' => 'Welcome, {name}!',
			_ => null,
		};
	}
}
