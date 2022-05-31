#!/bin/sh
file=test/coverage_helper_test.dart
touch file
echo "// Helper file to make coverage report for all dart files\n" >> $file
echo "// ignore_for_file: unused_import" >> $file
find lib -type f \( -iname "*.dart" ! -iname "*.g.dart" ! -iname "*.gr.dart" ! -iname "*.freezed.dart" ! -iname "generated_plugin_registrant.dart" ! -iname "*_state.dart" ! -iname "*_event.dart" \) | cut -c 4- | sort | awk -v package="$1" '{printf "import '\''package:collaction_app%s%s'\'';\n", package, $1}' >> $file
echo "void main(){}" >> $file