import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  ThemeNotifier themeNotifier;
  MockSharedPreferences preferences;
  setUp(() {
    preferences = MockSharedPreferences();
  });

  group('ThemeNotifer 첫 실행 시 테마 가져오기', () {
    test('preferences에 데이터가 없는 경우, System 테마 모드, light 테마 데이터를 가져온다.',
        () async {
      // arrange
      when(preferences.get(ThemeNotifier.KEY_THEME_MODE)).thenReturn(null);

      themeNotifier = ThemeNotifier(preferences: preferences);
      // act
      final themeMode = themeNotifier.getThemeMode();
      // assert
      expect(themeMode, AppTheme.system);
    });

    test('preferences 값이 light인 경우, light 테마 모드이고, primaryColor는 White',
        () async {
      // arrange
      when(preferences.get(ThemeNotifier.KEY_THEME_MODE))
          .thenReturn(AppTheme.light.value());

      themeNotifier = ThemeNotifier(preferences: preferences);
      // act
      final themeMode = themeNotifier.getThemeMode();
      // assert
      expect(themeMode, AppTheme.light);
    });

    test('preferences 값이 dark인 경우, dark 테마 모드이고, primaryColor는 Black',
        () async {
      // arrange
      when(preferences.get(ThemeNotifier.KEY_THEME_MODE))
          .thenReturn(AppTheme.dark.value());

      themeNotifier = ThemeNotifier(preferences: preferences);
      // act
      final themeMode = themeNotifier.getThemeMode();
      // assert
      expect(themeMode, AppTheme.dark);
    });

    test('preferences 값이 dark인 경우, dark 테마 모드이고, primaryColor는 Black',
        () async {
      // arrange
      when(preferences.get(ThemeNotifier.KEY_THEME_MODE))
          .thenReturn(AppTheme.dark.value());

      themeNotifier = ThemeNotifier(preferences: preferences);
      // act
      final themeMode = themeNotifier.getThemeMode();
      // assert
      expect(themeMode, AppTheme.dark);
    });
  });

  group('테마 변경', () {
    setUp(() {
      themeNotifier = ThemeNotifier(preferences: preferences);
    });
    test('테마모드를 light로 변경했을 때, preference에 light value를 저장해야한다.', () async {
      // act
      themeNotifier.setLightMode();
      // assert
      verify(preferences.setString(
          ThemeNotifier.KEY_THEME_MODE, AppTheme.light.value()));
    });

    test('테마모드를 light로 변경했을 때, preference에 dark value를 저장해야한다.', () async {
      // act
      themeNotifier.setDarkMode();
      // assert
      verify(preferences.setString(
          ThemeNotifier.KEY_THEME_MODE, AppTheme.dark.value()));
    });

    test('테마모드를 light로 변경했을 때, preference에 system value를 저장해야한다.', () async {
      // act
      themeNotifier.setSystemMode();
      // assert
      verify(preferences.setString(
          ThemeNotifier.KEY_THEME_MODE, AppTheme.system.value()));
    });
  });
}
