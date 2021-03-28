void httpLog([dynamic log, dynamic additional = ""]) {
  print("Http Log: $log $additional");
}

void infoLog([dynamic log, dynamic additional = ""]) {
  print("Info Log: $log $additional");
}

void errorLog([dynamic log, dynamic additional = ""]) {
  print("Error Log: $log $additional");
}
