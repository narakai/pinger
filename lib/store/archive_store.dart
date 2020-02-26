import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:pinger/model/ping_session.dart';
import 'package:pinger/service/pinger_prefs.dart';

part 'archive_store.g.dart';

@singleton
class ArchiveStore extends ArchiveStoreBase with _$ArchiveStore {
  final PingerPrefs _pingerPrefs;

  ArchiveStore(this._pingerPrefs);
}

abstract class ArchiveStoreBase with Store {
  PingerPrefs get _pingerPrefs;

  @observable
  List<PingSession> sessions;

  @action
  void init() {
    sessions = _pingerPrefs.getArchiveSessions() ??
        [
          PingSession(
            host: "dropbox.com",
            timestamp: DateTime.now().subtract(Duration(minutes: 10)),
            duration: Duration(minutes: 8, seconds: 7),
            results: PingResults.fromValues([
              30.0,
              75.0,
              34.0,
              59.0,
              3.0,
              13.0,
              205.0,
              12.0,
              120.0,
              22.0,
              64.0,
              48.0,
              51.0,
            ]),
          ),
          PingSession(
            host: "youtube.com",
            timestamp: DateTime.now().subtract(Duration(hours: 17)),
            duration: Duration(minutes: 3, seconds: 2),
            results: PingResults.fromValues([120.0, 200.0, 80.0, 192.0]),
          ),
          PingSession(
            host: "dropbox.com",
            timestamp: DateTime.now().subtract(Duration(days: 3)),
            duration: Duration(minutes: 35, seconds: 58),
            results: PingResults.fromValues(
              List.generate(120, (_) => Random().nextDouble() * 50.0),
            ),
          ),
          PingSession(
            host: "dropbox.com",
            timestamp: DateTime.now().subtract(Duration(days: 22)),
            duration: Duration(minutes: 99, seconds: 44),
            results: PingResults.fromValues([37.0, 88.0, 76.0, 92.0]),
          ),
        ];
  }
}