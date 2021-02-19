


import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/bloc/bloc.dart';

class MockGetVersionInfoForUpdate extends Mock implements GetVersionInfoForUpdate {}

void main() {
  SplashBloc splashBloc;
  MockGetVersionInfoForUpdate mockGetVersionInfoForUpdate;

  setUp(() {
    mockGetVersionInfoForUpdate = MockGetVersionInfoForUpdate();
    splashBloc = SplashBloc(getVersionInfo: mockGetVersionInfoForUpdate);
  });

  group('GetVersionInfoForUpdate Usecase', () {
    test('should return GetVersionInfo when splash page is loaded', () async {

    });
  });
}