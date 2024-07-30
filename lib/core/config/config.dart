class AppConfig {
  //mode can be - 'DEBUG' or 'UAT' or 'PROD'
  static const String _mode = 'DEBUG';

  static String getBaseUrl() {
    if (_mode == 'DEBUG') {
      return 'https://lab.pixel6.co/api';
    } else if (_mode == 'UAT') {
      return 'https://lab.pixel6.co/api';
    } else if (_mode == 'PROD') {
      return '';
    }
    return 'https://lab.pixel6.co/api';
  }
}
