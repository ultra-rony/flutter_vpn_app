plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "ru.rodrix.vpnapp"
    compileSdk = 35
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "ru.rodrix.vpnapp"
        minSdk = 26
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    splits {
        abi {
            isEnable = true
            reset()
            include("x86_64", "armeabi-v7a", "arm64-v8a")
            isUniversalApk = true
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            ndk {
                abiFilters.addAll(setOf("x86_64", "armeabi-v7a", "arm64-v8a"))
                debugSymbolLevel = "SYMBOL_TABLE"
            }
        }
    }

    applicationVariants.all {
        val variant = this
        if (variant.buildType.name == "release") {
            variant.outputs.all {
                val output = this as com.android.build.gradle.internal.api.BaseVariantOutputImpl
                val baseName = "vpnapp-v${variant.versionName}"
                val currentName = output.name

                val abi = when {
                    currentName.contains("arm64", ignoreCase = true) -> "arm64-v8a"
                    currentName.contains("v7a", ignoreCase = true) -> "armeabi-v7a"
                    currentName.contains("x86_64", ignoreCase = true) -> "x86_64"
                    currentName.contains("universal", ignoreCase = true) -> "universal"
                    else -> null
                }

                output.outputFileName = if (abi != null) "$baseName-$abi.apk" else "$baseName.apk"
            }
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}