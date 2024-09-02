import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:energise_test_app/data/api/i_api.dart';

class Api extends IApi {
  static const String _baseUrl = 'http://ip-api.com';

  Api()
      : _dio = Dio(
          BaseOptions(baseUrl: _baseUrl),
        )..interceptors.add(DioCacheInterceptor(options: _options));

  final Dio _dio;

  @override
  Future<Response<dynamic>> getLocation(String ip) {
    return _dio.get('/json/$ip');
  }

  static CacheOptions get _options => CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.request,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      );
}
