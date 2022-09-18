import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final hiveProvider = Provider(((ref) => Hive.initFlutter()));
