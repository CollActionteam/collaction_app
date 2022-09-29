#!/bin/sh
file=test/coverage_helper_test.dart
touch file

{
  printf "// Helper file to make coverage report for all dart files\n"
  echo "// ignore_for_file: unused_import"
  find lib -type f \( -iname "*.dart" ! -iname "generated_plugin_registrant.dart" \) -print0 | xargs -0 grep -L "^part of" | cut -c 4- | sort | awk -v package="$1" '{printf "import '\''package:collaction_app%s%s'\'';\n", package, $1}'
  echo "void main(){}"
} >>$file
