import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Current [ThemeMode] for the app, toggled from the app bar.
///
/// Defaults to [ThemeMode.light]. The preference is session-only and is not
/// persisted to local storage.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
