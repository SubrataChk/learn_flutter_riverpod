#!/usr/bin/env bash
# Scaffolds a new feature folder under lib/features/<name> with the same
# layout/pattern as the counter feature (data/domain/application/presentation).
#
# Usage:
#   ./scripts/create_feature.sh <feature_name>
# Example:
#   ./scripts/create_feature.sh todo
#   ./scripts/create_feature.sh user_profile

set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: ./scripts/create_feature.sh <feature_name>"
  echo "Example: ./scripts/create_feature.sh todo"
  exit 1
fi

# Normalize input to snake_case (lowercase, non-alnum -> underscore).
RAW="$1"
NAME=$(echo "$RAW" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '_')
NAME=$(echo "$NAME" | sed 's/^_*//; s/_*$//')

if [ -z "$NAME" ]; then
  echo "Invalid feature name: '$RAW'"
  exit 1
fi

# snake_case -> PascalCase (todo -> Todo, user_profile -> UserProfile).
PASCAL=$(echo "$NAME" | awk -F'_' '{
  out = "";
  for (i = 1; i <= NF; i++) {
    out = out toupper(substr($i,1,1)) substr($i,2);
  }
  print out;
}')

# PascalCase -> camelCase (for the provider variable name, e.g. userProfileProvider).
CAMEL="$(echo "${PASCAL:0:1}" | tr '[:upper:]' '[:lower:]')${PASCAL:1}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
FEATURE_DIR="$PROJECT_ROOT/lib/features/$NAME"

if [ -d "$FEATURE_DIR" ]; then
  echo "Feature '$NAME' already exists at lib/features/$NAME"
  exit 1
fi

mkdir -p \
  "$FEATURE_DIR/data" \
  "$FEATURE_DIR/domain" \
  "$FEATURE_DIR/application" \
  "$FEATURE_DIR/presentation/screens" \
  "$FEATURE_DIR/presentation/widgets"

cat > "$FEATURE_DIR/application/${NAME}_provider.dart" <<EOF
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the $NAME state and the logic to change it.
/// UI never mutates state directly — it only calls methods like [increment].
class ${PASCAL}Notifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;

  void reset() => state = 0;
}

final ${CAMEL}Provider = NotifierProvider<${PASCAL}Notifier, int>(
  ${PASCAL}Notifier.new,
);
EOF

cat > "$FEATURE_DIR/presentation/screens/${NAME}_screen.dart" <<EOF
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/${NAME}_provider.dart';

class ${PASCAL}Screen extends ConsumerWidget {
  const ${PASCAL}Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(${CAMEL}Provider);

    return Scaffold(
      appBar: AppBar(title: const Text('$PASCAL')),
      body: Center(
        child: Text(
          '\$value',
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(${CAMEL}Provider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
EOF

touch "$FEATURE_DIR/data/.gitkeep"
touch "$FEATURE_DIR/domain/.gitkeep"
touch "$FEATURE_DIR/presentation/widgets/.gitkeep"

echo "Created feature '$NAME' at lib/features/$NAME"
echo ""
echo "Files generated:"
echo "  lib/features/$NAME/application/${NAME}_provider.dart"
echo "  lib/features/$NAME/presentation/screens/${NAME}_screen.dart"
echo ""
echo "Next step: wire '${PASCAL}Screen' into app.dart or your router."
