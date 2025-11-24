#!/usr/bin/env bash
set -euo pipefail

# Creates the canonical lib/ directory layout used by Taskon.
# Usage (from repo root): bash tool/create_lib_structure.sh

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(pwd)"
lib_dir="$project_root/lib"

if [[ ! -d "$lib_dir" ]]; then
  echo "Error: lib/ directory not found under $project_root" >&2
  echo "Run this script from the root of a Flutter project." >&2
  exit 1
fi

directories=(
  core
  core/analytics
  core/constants
  core/errors
  core/router
  core/theme
  core/utils
  data
  data/datasources
  data/datasources/local
  data/datasources/remote
  data/models
  data/repositories
  features
  features/auth
  features/auth/controllers
  features/auth/views
  features/auth/widgets
  features/home
  features/home/views
  features/onboarding
  features/onboarding/controllers
  features/onboarding/views
  features/onboarding/widgets.dart
  features/splash
  features/splash/controllers
  features/splash/views
  services
)

files=(
  core/constants/app_config.constants.dart
#   core/constants/shared_prefs.constants.dart
  core/router/router.dart
  core/theme/app_colors.dart
#   core/theme/app_text_styles.dart
#   core/theme/app_theme.dart
#   core/utils/shared_prefs.utils.dart
#   core/utils/snackbar.util.dart
#   core/utils/validator.util.dart
#   data/repositories/auth.repository.dart
#   data/repositories/user.repository.dart
#   features/auth/controllers/auth.controller.dart
#   features/auth/views/email.view.dart
#   features/auth/views/login.screen.dart
#   features/auth/views/otp.view.dart
#   features/auth/views/register.screen.dart
#   features/home/views/home.screen.dart
#   features/onboarding/views/onboarding.screen.dart
#   features/onboarding/widgets.dart/feature_item.widget.dart
#   features/splash/controllers/startup.controller.dart
#   features/splash/views/splash.screen.dart
)

created_dirs=()
created_files=()

for rel_dir in "${directories[@]}"; do
  abs_dir="$lib_dir/$rel_dir"
  if [[ ! -d "$abs_dir" ]]; then
    mkdir -p "$abs_dir"
    created_dirs+=("$rel_dir")
  fi
done

placeholder_for() {
  local rel_path="$1"
  local base_name
  base_name="${rel_path##*/}"
  if [[ "$rel_path" == "main.dart" ]]; then
    cat <<'TPL'
import 'package:flutter/material.dart';

void main() {
  runApp(const PlaceholderApp());
}

class PlaceholderApp extends StatelessWidget {
  const PlaceholderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello from Taskon structure generator'),
        ),
      ),
    );
  }
}
TPL
    return
  fi
  printf '/// Placeholder for %s.\n' "$base_name"
}

for rel_file in "${files[@]}"; do
  abs_file="$lib_dir/$rel_file"
  if [[ ! -f "$abs_file" ]]; then
    mkdir -p "$(dirname "$abs_file")"
    placeholder_for "$rel_file" >"$abs_file"
    created_files+=("$rel_file")
  fi
done

printf 'Lib structure sync complete.\n'
if [[ ${#created_dirs[@]} -gt 0 ]]; then
  printf 'Created directories:\n'
  for dir in "${created_dirs[@]}"; do
    printf '  - lib/%s\n' "$dir"
  done
fi
if [[ ${#created_files[@]} -gt 0 ]]; then
  printf 'Created files:\n'
  for file in "${created_files[@]}"; do
    printf '  - lib/%s\n' "$file"
  done
fi
if [[ ${#created_dirs[@]} -eq 0 && ${#created_files[@]} -eq 0 ]]; then
  printf 'Everything already matched the expected structure.\n'
fi
