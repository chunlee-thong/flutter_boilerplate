import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


T readProvider<T>(BuildContext context,[bool listen = false]) => Provider.of<T>(context, listen: listen);