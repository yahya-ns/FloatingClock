# Flutter ProGuard Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Flutter Deferred Components (Google Play Core not bundled)
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
-dontwarn io.flutter.**

# Keep application code and services
-keep class io.github.amchii.floatingclock.** { *; }

# Prevent obfuscation of MethodChannel and annotated members
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}
