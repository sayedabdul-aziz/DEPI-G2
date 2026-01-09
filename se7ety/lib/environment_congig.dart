enum EnvironmentConfig { staging, production }

abstract class Environment {
  String get baseUrl;
  String get firebaseId;
}

class StagingEnvironment implements Environment {
  @override
  String get baseUrl => 'https://staging.se7ety.com';

  @override
  String get firebaseId => 'se7ety-staging';
}

class ProductionEnvironment implements Environment {
  @override
  String get baseUrl => 'https://se7ety.com';

  @override
  String get firebaseId => 'se7ety-production';
}


getBaseUrl(EnvironmentConfig config) {
  switch (config) {
    case EnvironmentConfig.staging:
      return StagingEnvironment().baseUrl;
    case EnvironmentConfig.production:
      return ProductionEnvironment().baseUrl;
  }
}
