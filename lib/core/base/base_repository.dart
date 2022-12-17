import 'package:postbar/core/base/index.dart';

abstract class BaseRepository<P extends BaseProvider> {
  BaseRepository({
    required this.provider,
  });

  final P provider;
}
