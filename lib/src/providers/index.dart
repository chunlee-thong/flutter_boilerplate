import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Use this instead of context extension because extension isn't auto import
T readProvider<T>(BuildContext context, [bool listen = false]) => Provider.of<T>(context, listen: listen);
