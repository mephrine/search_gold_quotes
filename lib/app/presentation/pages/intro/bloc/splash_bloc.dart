import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/version_info.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_version_info.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart';
import 'package:search_gold_quotes/core/usecases/no_params.dart';
import 'package:search_gold_quotes/core/error/error_messages.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

import 'bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetVersionInfo getVersionInfo;

  SplashBloc({@required GetVersionInfo versionInfo})
      : assert(null != versionInfo),
        getVersionInfo = versionInfo,
        super(Empty());

  SplashState get initialState => Empty();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is GetVersionInfoForUpdate) {
      yield Loading();
      final failOrVersionInfo = await getVersionInfo(NoParams());
      yield* failOrVersionInfo.fold((failure) async* {
        yield Error(message: SERVER_FAILURE_MESSAGE);
      }, (versionInfo) async* {
        final needsForceUpdate = await _needsForceUpdate(versionInfo);
        yield Loaded(
            needsForceUpdate: needsForceUpdate,
            updateMessage: Strings.appUpdateAlertMessage);
      });
    }
  }

  Future<bool> _needsForceUpdate(VersionInfo versionInfo) async {
    final currentVersion = await DeviceUtils.version;

    return Future.value(
        !currentVersionIsLatest(currentVersion, versionInfo.latestVersion));
  }

  bool currentVersionIsLatest(String currentVersion, String latestVersion) {
    try {
      final currentVersionSplitList = currentVersion.split('.');
      final latestVersionSplitList = latestVersion.split('.');
      final currentVersionLength = currentVersionSplitList.length;
      final latestVersionLength = latestVersionSplitList.length;
      final maxListLength = max(currentVersionLength, latestVersionLength);

      for (var i = 0; i < maxListLength - currentVersionLength; i++) {
        currentVersionSplitList.add("0");
      }

      for (var i = 0; i < maxListLength - latestVersionLength; i++) {
        latestVersionSplitList.add("0");
      }

      for (var index = 0; index < maxListLength; index++) {
        final currentVersionIsHigher = int.parse(currentVersionSplitList[index])
            .isHigherThan(int.parse(latestVersionSplitList[index]));
        if (currentVersionIsHigher == CompareVersion.higher) {
          return true;
        } else if (currentVersionIsHigher == CompareVersion.lower) {
          return false;
        }
      }

      return true;
    } catch (exception) {
      return true;
    }
  }
}

enum CompareVersion { lower, equal, higher }

extension CompareInt on int {
  CompareVersion isHigherThan(int target) {
    if (this > target) {
      return CompareVersion.higher;
    } else if (this == target) {
      return CompareVersion.equal;
    }
    return CompareVersion.lower;
  }
}
