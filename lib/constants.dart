enum Environment { DEV, STAGING, PROD }

class Constants {
  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.qaConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get BASE_URL {
    return _config[_Config.BASE_URL];
  }

  static get CONNECTION_TIMEOUT {
    return _config[_Config.CONNECTION_TIMEOUT];
  }
}

class _Config {
  static const BASE_URL = "BASE_URL";
  static const CONNECTION_TIMEOUT = 15000;

  static Map<String, dynamic> debugConstants = {
    BASE_URL: "https://jsonplaceholder.typicode.com/",
  };

  static Map<String, dynamic> qaConstants = {
    BASE_URL: "https://staging1.example.com/",
  };

  static Map<String, dynamic> prodConstants = {
    BASE_URL: "https://itsallwidgets.com/",
  };
}
