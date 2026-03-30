---
name: xcode
description: Xcode project management — XcodeGen-based project generation, SPM integration, build/run commands, and common troubleshooting for iOS/macOS development
---

# Xcode Project Management

## Project Generation with XcodeGen

**Never create Xcode projects manually** (File > New > Project). Use XcodeGen to generate `.xcodeproj` files from YAML specs. This avoids the wrapper directory problem, `.pbxproj` merge conflicts, and manual source file management.

### Install

```bash
brew install xcodegen
```

### Project Spec Pattern

For a Swift package with library targets + app targets, the convention is:

```
ProjectRoot/
  Package.swift              # Defines library targets
  Sources/
    MyLib/                   # Library source
    MyApp/                   # App source
  MyApp-project.yml          # XcodeGen spec (committed to git)
  MyApp.xcodeproj/           # Generated (gitignored)
```

### Spec File Template (macOS App)

```yaml
name: MyApp
options:
  bundleIdPrefix: com.example
  deploymentTarget:
    macOS: "14.0"
  createIntermediateGroups: true

packages:
  MyPackage:
    path: .

targets:
  MyApp:
    type: application
    platform: macOS
    sources:
      - path: Sources/MyApp
    dependencies:
      - package: MyPackage
        product: MyLib
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: com.example.myapp
        GENERATE_INFOPLIST_FILE: true
        SWIFT_VERSION: "6.0"
```

### Spec File Template (iOS App)

```yaml
name: MyApp
options:
  bundleIdPrefix: com.example
  deploymentTarget:
    iOS: "17.0"
  createIntermediateGroups: true

packages:
  MyPackage:
    path: .

targets:
  MyApp:
    type: application
    platform: iOS
    sources:
      - path: Sources/MyApp
    dependencies:
      - package: MyPackage
        product: MyLib
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: com.example.myapp
        GENERATE_INFOPLIST_FILE: true
        SWIFT_VERSION: "6.0"
```

### Generate & Open

```bash
xcodegen generate --spec MyApp-project.yml
open MyApp.xcodeproj
```

### Regenerate After Changes

Run `xcodegen generate` again whenever you:
- Add or remove source files (XcodeGen reads the filesystem)
- Change dependencies in Package.swift
- Modify build settings

## Git Conventions

**Commit the YAML specs. Gitignore the `.xcodeproj` files.**

```gitignore
# .gitignore
*.xcodeproj
xcuserdata/
*.xcscmblueprint
```

The `.xcodeproj` is a generated artifact. Any developer regenerates it after cloning:

```bash
git clone <repo>
xcodegen generate --spec MyApp-project.yml
open MyApp.xcodeproj
```

## Package.swift + Xcode Relationship

- `Package.swift` defines **library targets** only (no app targets)
- SPM cannot produce `.app` bundles — only CLI executables and libraries
- App targets require `.xcodeproj` files, which reference the local package via `packages: { path: . }`
- The Xcode project links the SPM library products as framework dependencies

## Building & Running

### macOS App

```bash
# Via Xcode
open MyApp.xcodeproj   # Select "My Mac", Cmd+R

# Via terminal (libraries only, no app bundle)
swift build
```

### iOS App (Simulator)

```bash
open MyApp.xcodeproj   # Select iPhone simulator, Cmd+R
```

### Library-Only Build (no Xcode needed)

```bash
swift build            # Builds all library targets from Package.swift
swift test             # Runs tests
```

## Files in Project Are Auto-Detected

When creating files inside an Xcode project's source directory, Xcode picks them up automatically if the parent folder is already a group in the project. After adding files, regenerate with XcodeGen to be safe.

### When Manual "Add Files" IS Required

1. New top-level folders not yet in the project
2. Files outside the project's `sources:` path
3. Files you want to reference but not copy

If using XcodeGen, just regenerate — it reads the filesystem and adds everything.

## Common Issues

### "Xcode creates a wrapper directory"
Xcode's File > New > Project always nests `ProjectName/ProjectName.xcodeproj`. This is why we use XcodeGen instead.

### "Copy items if needed" dialog
When adding existing files, **uncheck** "Copy items if needed". Choose "Create groups" (not "Create folder references") for compilable source code.

### Access control across modules
Types in library targets used by app targets must be `public`. SPM's default access level is `internal`, which means cross-module references won't compile. Audit after splitting into modules.

### Transitive dependency not found
If target A depends on a library that transitively depends on another library, A may need to declare that dependency explicitly. Don't rely on transitive deps — make all imports explicit.

### SourceKit LSP shows false errors
Xcode's SourceKit cache can get stale after restructuring. Clean build folder (Cmd+Shift+K), restart Xcode, or delete `DerivedData`:

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData
```
