allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureNamespace = {
        val android = extensions.findByName("android")
        if (android != null) {
            // 1. Fix missing namespace for AGP 8+ compatibility
            try {
                val getNamespace = android.javaClass.getMethod("getNamespace")
                val currentNamespace = getNamespace.invoke(android)
                if (currentNamespace == null || currentNamespace.toString().isEmpty()) {
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    val cleanName = project.name.replace("-", "_").replace(" ", "_")
                    val fallbackNamespace = "dev.isar.$cleanName"
                    setNamespace.invoke(android, fallbackNamespace)
                    logger.quiet("Automatically set missing namespace for subproject :${project.name} to $fallbackNamespace")
                }
            } catch (e: Exception) {
                // Ignore if method not found
            }

            // 2. Force compileSdkVersion to 34 to fix "android:attr/lStar not found" (API 31+ attributes)
            try {
                val setCompileSdk = android.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType)
                setCompileSdk.invoke(android, 34)
                logger.quiet("Forced compileSdkVersion to 34 for subproject :${project.name}")
            } catch (e: Exception) {
                try {
                    val setCompileSdk2 = android.javaClass.getMethod("setCompileSdk", java.lang.Integer::class.java)
                    setCompileSdk2.invoke(android, 34)
                    logger.quiet("Forced compileSdk to 34 for subproject :${project.name}")
                } catch (ex: Exception) {}
            }

            // 3. Force targetSdkVersion to 34 in defaultConfig
            try {
                val defaultConfig = android.javaClass.getMethod("getDefaultConfig").invoke(android)
                if (defaultConfig != null) {
                    try {
                        val setTargetSdk = defaultConfig.javaClass.getMethod("setTargetSdkVersion", Int::class.javaPrimitiveType)
                        setTargetSdk.invoke(defaultConfig, 34)
                        logger.quiet("Forced targetSdkVersion to 34 for subproject :${project.name}")
                    } catch (e: Exception) {
                        try {
                            val setTargetSdk2 = defaultConfig.javaClass.getMethod("setTargetSdk", java.lang.Integer::class.java)
                            setTargetSdk2.invoke(defaultConfig, 34)
                            logger.quiet("Forced targetSdk to 34 for subproject :${project.name}")
                        } catch (ex: Exception) {}
                    }
                }
            } catch (e: Exception) {}
        }
    }

    if (state.executed) {
        configureNamespace()
    } else {
        afterEvaluate {
            configureNamespace()
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
