#!/bin/bash

mkdir -p ../lib/src/proto/src
chmod 777 ../lib/src/proto/src ../lib/src/proto ../lib/src/ ../lib
rm -r ../lib/src/proto/src/*

mkdir -p ../ios/Classes/Proto
chmod 777 ../ios/Classes/Proto ../ios/Classes ../ios
rm -r ../ios/Classes/Proto/*

rm -r ../android/src/main/kotlin/com/texture_image/proto/*

if [ -d "../protos" ]; then
  cd ../protos || (echo "Update failed: proto source dir not exists" && exit)

  echo "Generating dart ProtoBuf files..."
  for file in *.proto; do
    echo "$file"

    protoc "$file" --dart_out=../lib/src/proto/src/
    protoc "$file" --java_out=../android/src/main/kotlin/
    protoc "$file" --objc_out=../ios/Classes/Proto/
  done
fi

echo "All ProtoBuf files have been created!"
echo "Collecting dart ProtoBuf header files..."

PB_SOURCE="../lib/src/proto"
PB_HEADER="$PB_SOURCE"/pb_header.dart

function genTemplateHeader() {
  {
    printf "/// ProtoBuf Headers\n///\n"
    printf "/// This file is generated by shell script on %s, please DON'T edit this file manually.\n\n" "$(date +%Y-%m-%d)"
  } >>"$PB_HEADER"
}

function collectHeaders() {
  local DART_PBS="$PB_SOURCE"/src/

  for file in "$DART_PBS"/*; do
    local filename=${file##*/}
    echo "$filename"
    printf "export \"src/%s\";\n" "$filename" >>"$PB_HEADER"
  done
}

# Create file and emptying content if it's exists
touch "$PB_HEADER" && : >"$PB_HEADER"

# Insert file description and export statements
genTemplateHeader

touch "$PB_HEADER"
collectHeaders

echo 'Update PB done!'
