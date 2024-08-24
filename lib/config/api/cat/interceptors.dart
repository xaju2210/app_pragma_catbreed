import 'package:app_pragma_prueba/config/constants/utils.dart';
import 'package:dio/dio.dart';

///Desarrollado por © Xavier Zuñiga
class AppInterceptors extends Interceptor {
  final Dio dio;
  final bool authQuery;

  AppInterceptors(
    this.dio, {
    this.authQuery = false,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (authQuery) options.queryParameters["api_key"] = Utils().apiKey;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(
      Response(
        requestOptions: response.requestOptions,
        data: {
          "code": 0,
          "message": "",
          "data": response.data,
        },
      ),
      handler,
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String messageError = "";

    try {
      switch (err.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw DeadlineExceededException(err.requestOptions);
        case DioExceptionType.badResponse:
          switch (err.response?.statusCode) {
            case 400:
              throw BadRequestException(err.requestOptions);
            case 401:
              throw UnauthorizedException(err.requestOptions);
            case 404:
              throw NotFoundException(err.requestOptions);
            case 409:
              throw ConflictException(err.requestOptions);
            case 500:
              throw InternalServerErrorException(err.requestOptions);
          }
          break;
        case DioExceptionType.cancel:
          break;
        case DioExceptionType.badCertificate:
          break;
        case DioExceptionType.unknown:
          throw UnknowException(err.requestOptions);
      }
    } on DioException catch (err, _) {
      messageError = err.toString();
    }
    return handler.resolve(
      Response(
        requestOptions: err.requestOptions,
        data: {
          "code": -1,
          "message": messageError,
          "data": null,
        },
      ),
    );
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: Ruta desconocida al hacer la solicitud, favor de contactarse con su proveedor.';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: Ha ocurrido un error al comunicarse con el servidor, favor de contactarse con su proveedor.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: Ha ocurrido un conflicto interno, favor de contactarse con su proveedor. ';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: No tiene los permisos suficientes para realizar esta acción, favor de contactarse con su proveedor. ';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: La información solicitada no ha sido encontrada, favor de contactarse con su proveedor. ';
    // return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: No se detecta conexión de internet, favor de intentar nuevamente.';
    // return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: La conexión ha tardado demasiado, favor de inter nuevamente.';
  }
}

class UnknowException extends DioException {
  UnknowException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error: Ha ocurrido un error desconocido al establecer la conexión, favor de comunicarse con su proveedor';
  }
}
