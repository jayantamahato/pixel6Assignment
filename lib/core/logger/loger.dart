import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger();
  static e({msg = ''}) {
    _logger.e(msg);
  }

  static w({msg = ''}) {
    _logger.w(msg);
  }

  static d({msg = ''}) {
    _logger.d(msg);
  }
}
