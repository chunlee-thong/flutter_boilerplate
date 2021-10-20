import 'package:flutter_boiler_plate/src/api/client/http_client.dart';
import 'package:flutter_boiler_plate/src/api/repository/base_api.dart';
import 'package:flutter_boiler_plate/src/models/others/user_credential.dart';
import 'package:flutter_boiler_plate/src/utils/logger.dart';
import 'package:test/test.dart';

void main() {
  test('Testing http request', () async {
    DefaultHttpClient.init();
    MemoryUserCredential.instance.initMemoryCredential(
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
