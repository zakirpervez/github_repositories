package com.example.ghrepositories

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class GHReposApplication : Application() {

    lateinit var flutterEngine: FlutterEngine

    override fun onCreate() {
        super.onCreate()
        // Initialize flutter engine
        flutterEngine = FlutterEngine(this)

        // Setup default dart executors
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        // Cached the flutter engine so we can use it later by flutter activity
        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_NAME, flutterEngine)
    }

    companion object {
        const val FLUTTER_ENGINE_NAME = "github_repositories"
    }
}