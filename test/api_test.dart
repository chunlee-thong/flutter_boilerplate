import 'package:test/test.dart';

import '../lib/src/http/client/base_api.dart';
import '../lib/src/http/client/http_client.dart';
import '../lib/src/models/others/user_credential.dart';
import '../lib/src/utils/logger.dart';

void main() {
  test('Testing http request', () async {
    DefaultHttpClient.init();
    UserCredential.instance.initLocalCredential(
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwZWNmZTUyZmYxNzc0MzhiMWM0OTE1MiIsInJvbGUiOiJhZG1pbiIsImlzX3JlZnJlc2giOmZhbHNlLCJpYXQiOjE2MzM3OTI4MjEsImV4cCI6MTYzMzc5MzEyMX0.eeZcOo8S1k1G98MOzYtA7rWdtw4XqLm_3AK461P6VJ4",
        userId: "data");
    var api = API();

    var response = await api.httpRequest(
      path: "/",
      onSuccess: (response) {
        return response.data;
      },
    );
    infoLog(response);
    expect(response.runtimeType, 1);
  });
}
