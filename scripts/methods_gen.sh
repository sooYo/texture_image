#!/bin/bash

METHOD_DEFINES='../sources/methods'
DART_SOURCE="../lib/src/constants/methods.dart"
KOTLIN_SOURCE="../android/src/main/kotlin/com/texture_image/constants/Methods.kt"
OBJC_SOURCE="../ios/Classes/Constants/Methods"

echo "Generating methods declaration files..."

if [ ! -f "$METHOD_DEFINES" ]; then
  echo "Target definition file not exists, abort"
  exist -1
fi

function insertHeaderFileDeclaration() {
  {
    printf "/// Plugin API list\n///\n"
    printf "/// This file is generated by shell script on %s, please don't edit this file manually\n\n" "$(date +%Y-%m-%d)"
  } >>"$1"
}

function genDartTemplateFile() {
  # Empty this file or create if not exists
  touch "$DART_SOURCE" && : >"$DART_SOURCE"

  insertHeaderFileDeclaration "$DART_SOURCE"

  {
    printf "class Methods {\n"
    printf "}"
  } >>"$DART_SOURCE"
}

function genKotlinTemplateFile() {
  touch "$KOTLIN_SOURCE" && : >"$KOTLIN_SOURCE"

  insertHeaderFileDeclaration "$KOTLIN_SOURCE"

  {
    printf "package com.texture_image.constants\n\n"
    printf "class Methods {\n"
    printf "    companion object {\n"
    printf "    }\n"
    printf "}"
  } >>"$KOTLIN_SOURCE"
}

function genObjcTemplateFile() {
  local header
  local impl

  header="$OBJC_SOURCE.h"
  impl="$OBJC_SOURCE.m"

  touch "$header" && : >"$header"
  touch "$impl" && : >"$impl"

  insertHeaderFileDeclaration "$header"
  insertHeaderFileDeclaration "$impl"

  printf "#import <Foundation/Foundation.h>\n\n" >>"$header"
  printf "#import \"Methods.h\"\n\n" >>"$impl"
}

function genTemplateFiles() {
  genDartTemplateFile   # Dart
  genKotlinTemplateFile # Kotlin
  genObjcTemplateFile   # Objc
}

function fillDartTemplateFile() {
  sed -i '' -e "/}/ i \\
  // $1\\
  static const $2 = \"$2\";\\
  " "$DART_SOURCE"
}

function fillKotlinTemplateFile() {
  sed -i '' -e "/    }/ i \\
        // $1\\
        const val $2 = \"$2\"\\
        " "$KOTLIN_SOURCE"
}

# Insert methods to iOS platform
function fillObjcTemplateFile() {
  local header
  local impl

  header="$OBJC_SOURCE.h"
  impl="$OBJC_SOURCE.m"

  {
    printf "// %s\n" "$1"
    printf "extern NSString *const %s;\n\n" "$2"
  } >>"$header"

  {
    printf "// %s\n" "$1"
    printf "NSString *const %s = @\"%s\";\n\n" "$2" "$2"
  } >>"$impl"
}

function parseMethodsDefine() {
  local file="$1"

  while IFS= read -r line || [ -n "$line" ]; do
    # Trim lines and ignore comment lines
    trimmed="$(eval echo "$line")"
    if [[ "$trimmed" == //* || -z "$trimmed" ]]; then
      continue
    fi

    echo "$trimmed"

    # Separate by space and insert into target files
    IFS='#'
    read -ra array <<<"$trimmed"

    comment=${array[1]} || ''
    variable=${array[0]}

    fillDartTemplateFile "$comment" "$variable"
    fillKotlinTemplateFile "$comment" "$variable"
    fillObjcTemplateFile "$comment" "$variable"

  done <"$file"
}

genTemplateFiles
parseMethodsDefine "$METHOD_DEFINES"

echo "Method list files generated" && exit 0
