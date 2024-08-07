import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repositories/remote/api_interceptor.dart';
import 'package:mockito/mockito.dart';

class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}
class MockResponseInterceptorHandler extends Mock implements ResponseInterceptorHandler {}
class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

void main() {
  late MockRequestInterceptorHandler mockRequestHandler;
  late MockResponseInterceptorHandler mockResponseHandler;
  late MockErrorInterceptorHandler mockErrorHandler;

  late ApiInterceptor apiInterceptor;

  setUp(() {
    mockRequestHandler = MockRequestInterceptorHandler();
    mockResponseHandler = MockResponseInterceptorHandler();
    mockErrorHandler = MockErrorInterceptorHandler();
    apiInterceptor = ApiInterceptor();
  });

  group("ApiInterceptor Tests", () {
    test("onRequest adds and Accept header and call next", () {
      final options = RequestOptions(path: '/test');
      apiInterceptor.onRequest(options, mockRequestHandler);
      expect(options.headers["Accept"], "application/json");
      verify(mockRequestHandler.next(options)).called(1);
    });

    test('onRequest does not add incorrect headers', () {
      final options = RequestOptions(path: '/test');
      apiInterceptor.onRequest(options, mockRequestHandler);
      expect(options.headers["Accept"], "application/json");
      expect(options.headers.containsKey("Incorrect-Header"), false);
      verify(mockRequestHandler.next(options)).called(1);
    });

    test("onResponse log success and call next", () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: 'Success'
      );

      apiInterceptor.onResponse(response, mockResponseHandler);
      verify(mockResponseHandler.next(response)).called(1);
    });

    test("onError logs error and calls next", () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        error: 'Error',
        type: DioExceptionType.unknown,
      );

      apiInterceptor.onError(error, mockErrorHandler);
      verify(mockErrorHandler.next(error)).called(1);
    });
  });
}
