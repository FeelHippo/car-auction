import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';

class DioLogger extends Interceptor {
  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// InitialTab count to logPrint json response
  static const int kInitialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Print compact json response
  final bool compact;

  /// Width size per logPrint
  final int maxWidth;

  /// Size in which the Uint8List will be splitted
  static const int chunkSize = 20;

  /// Log printer; defaults logPrint log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  final void Function(Object object) logPrint;

  DioLogger({
    this.request = true,
    this.requestHeader = false,
    this.requestBody = false,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.maxWidth = 90,
    this.compact = true,
    this.logPrint = print,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (request) {
      _printRequestHeader(options);
    }
    if (requestHeader) {
      _printMapAsTable(options.queryParameters, header: 'Query Parameters');
      final Map<String, dynamic> requestHeaders = <String, dynamic>{};
      requestHeaders.addAll(options.headers);
      requestHeaders['contentType'] = options.contentType?.toString();
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout?.toString();
      requestHeaders['receiveTimeout'] = options.receiveTimeout?.toString();
      _printMapAsTable(requestHeaders, header: 'Headers');
      _printMapAsTable(options.extra, header: 'Extras');
    }
    if (requestBody && options.method != 'GET') {
      final dynamic data = options.data;
      if (data != null) {
        if (data is Map)
          _printMapAsTable(options.data as Map<String, dynamic>?,
              header: 'Body');
        if (data is FormData) {
          final Map<String, dynamic> formDataMap = <String, dynamic>{}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(formDataMap, header: 'Form data | ${data.boundary}');
        } else {
          _printBlock(data.toString());
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      if (err.type == DioExceptionType.badResponse) {
        final Uri? uri = err.response?.requestOptions.uri;
        _printBoxed(
          header:
              'DioError ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}',
          text: uri.toString(),
        );
        if (err.response != null && err.response?.data != null) {
          logPrint('╔ ${err.type.toString()}');
          _printResponse(err.response!);
        }
        _printLine('╚');
        logPrint('');
      } else {
        _printBoxed(header: 'DioError ║ ${err.type}', text: err.message);
      }
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _printResponseHeader(response);
    if (responseHeader) {
      final Map<String, String> responseHeaders = <String, String>{};
      response.headers.forEach((String k, List<String> list) =>
          responseHeaders[k] = list.toString());
      _printMapAsTable(responseHeaders, header: 'Headers');
    }

    if (responseBody) {
      logPrint('╔ Body');
      logPrint('║');
      _printResponse(response);
      logPrint('║');
      _printLine('╚');
    }
    super.onResponse(response, handler);
  }

  void _printBoxed({String? header, String? text}) {
    logPrint('');
    logPrint('╔╣ $header');
    logPrint('║  $text');
    _printLine('╚');
  }

  void _printResponse(Response<dynamic> response) {
    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(response.data as Map<String, dynamic>);
      } else if (response.data is Uint8List) {
        logPrint('║${_indent()}[');
        _printUint8List(response.data as Uint8List);
        logPrint('║${_indent()}]');
      } else if (response.data is List) {
        logPrint('║${_indent()}[');
        _printList(response.data as List<dynamic>);
        logPrint('║${_indent()}]');
      } else {
        _printBlock(response.data.toString());
      }
    }
  }

  void _printResponseHeader(Response<dynamic> response) {
    final Uri uri = response.requestOptions.uri;
    final String method = response.requestOptions.method;
    _printBoxed(
        header:
            'Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}',
        text: uri.toString());
  }

  void _printRequestHeader(RequestOptions options) {
    final Uri uri = options.uri;
    final String method = options.method;
    _printBoxed(header: 'Request ║ $method ', text: uri.toString());
  }

  void _printLine([String pre = '', String suf = '╝']) =>
      logPrint('$pre${'═' * maxWidth}$suf');

  void _printKV(String? key, Object? v) {
    final String pre = '╟ $key: ';
    final String msg = v.toString();

    if (pre.length + msg.length > maxWidth) {
      logPrint(pre);
      _printBlock(msg);
    } else {
      logPrint('$pre$msg');
    }
  }

  void _printBlock(String msg) {
    final int lines = (msg.length / maxWidth).ceil();
    for (int i = 0; i < lines; ++i) {
      logPrint((i >= 0 ? '║ ' : '') +
          msg.substring(i * maxWidth,
              math.min<int>(i * maxWidth + maxWidth, msg.length)));
    }
  }

  String _indent([int tabCount = kInitialTab]) => tabStep * tabCount;

  void _printPrettyMap(
    Map<dynamic, dynamic> data, {
    int initialTab = kInitialTab,
    bool isListItem = false,
    bool isLast = false,
  }) {
    int tabs = initialTab;
    final bool isRoot = tabs == kInitialTab;
    final String initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) logPrint('║$initialIndent{');

    data.keys.toList().asMap().forEach((int index, dynamic key) {
      final bool isLast = index == data.length - 1;
      dynamic value = data[key];
      if (value is String) {
        value = '"${value.toString().replaceAll(RegExp(r'([\r\n])+'), " ")}"';
      }
      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          logPrint('║${_indent(tabs)} $key: $value${!isLast ? ',' : ''}');
        } else {
          logPrint('║${_indent(tabs)} $key: {');
          _printPrettyMap(value, initialTab: tabs);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value)) {
          logPrint('║${_indent(tabs)} $key: ${value.toString()}');
        } else {
          logPrint('║${_indent(tabs)} $key: [');
          _printList(value, tabs: tabs);
          logPrint('║${_indent(tabs)} ]${isLast ? '' : ','}');
        }
      } else {
        final String msg = value.toString().replaceAll('\n', '');
        final String indent = _indent(tabs);
        final int linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final int lines = (msg.length / linWidth).ceil();
          for (int i = 0; i < lines; ++i) {
            logPrint(
                '║${_indent(tabs)} ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}');
          }
        } else {
          logPrint('║${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}');
        }
      }
    });

    logPrint('║$initialIndent}${isListItem && !isLast ? ',' : ''}');
  }

  void _printList(List<dynamic> list, {int tabs = kInitialTab}) {
    list.asMap().forEach((int i, dynamic e) {
      final bool isLast = i == list.length - 1;
      if (e is Map) {
        if (compact && _canFlattenMap(e)) {
          logPrint('║${_indent(tabs)}  $e${!isLast ? ',' : ''}');
        } else {
          _printPrettyMap(e,
              initialTab: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        logPrint('║${_indent(tabs + 2)} $e${isLast ? '' : ','}');
      }
    });
  }

  void _printUint8List(Uint8List list, {int tabs = kInitialTab}) {
    List<dynamic> chunks = <dynamic>[];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
            i, i + chunkSize > list.length ? list.length : i + chunkSize),
      );
    }
    for (dynamic element in chunks) {
      logPrint('║${_indent(tabs)} ${element.join(", ")}');
    }
  }

  bool _canFlattenMap(Map<dynamic, dynamic> map) {
    return map.values
            .where((dynamic val) => val is Map || val is List)
            .isEmpty &&
        map.toString().length < maxWidth;
  }

  bool _canFlattenList(List<dynamic> list) {
    return list.length < 10 && list.toString().length < maxWidth;
  }

  void _printMapAsTable(Map<dynamic, dynamic>? map, {String? header}) {
    if (map == null || map.isEmpty) return;
    logPrint('╔ $header ');
    map.forEach(
        (dynamic key, dynamic value) => _printKV(key.toString(), value));
    _printLine('╚');
  }
}
