import 'package:flutter/material.dart';

/// A helper class for functions related to cloud operations.
class MagicCloudHelperFunctions {
  /// Checks the state of a single record snapshot from a FutureBuilder.
  ///
  /// Returns a widget based on the state of the snapshot:
  /// - If waiting: returns a [CircularProgressIndicator].
  /// - If no data: returns a 'No Data Found!' message.
  /// - If has error: returns an error message.
  /// - If data is available: returns null.
  ///
  /// [snapshot]: The [AsyncSnapshot] from the FutureBuilder.
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    return null;
  }

  /// Checks the state of a multiple record snapshot from a FutureBuilder.
  ///
  /// Returns a widget based on the state of the snapshot:
  /// - If waiting: returns the provided [loader] or a [CircularProgressIndicator].
  /// - If no data or data is empty: returns the provided [nothingFound] widget or a 'No Data Found!' message.
  /// - If has error: returns the provided [error] widget or an error message.
  /// - If data is available: returns null.
  ///
  /// [snapshot]: The [AsyncSnapshot] from the FutureBuilder.
  /// [loader]: The widget to show while loading.
  /// [error]: The widget to show on error.
  /// [nothingFound]: The widget to show when no data is found.
  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    return null;
  }
}
