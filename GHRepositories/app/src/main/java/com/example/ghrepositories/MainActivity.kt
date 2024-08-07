package com.example.ghrepositories

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Devices
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.ghrepositories.components.CommitList
import com.example.ghrepositories.components.ImageBanner
import com.example.ghrepositories.components.TitleText
import com.example.ghrepositories.model.Repository
import com.example.ghrepositories.ui.theme.GHRepositoriesTheme
import com.example.ghrepositories.util.appMethodChanel
import com.example.ghrepositories.util.transferDataMethodName
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : ComponentActivity() {

    private var repository by mutableStateOf<Repository?>(null)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            GHRepositoriesTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background
                ) {
                    MainScreen(repository)
                }
            }
        }
        val flutterEngine = (application as GHReposApplication).flutterEngine
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, appMethodChanel)
            .setMethodCallHandler { call, result ->
                if (call.method == transferDataMethodName) {
                    val repoJson = call.arguments.toString()
                    val gson = Gson()
                    val repo: Repository =
                        gson.fromJson(repoJson, Repository::class.java)
                    updateRepository(repo)
                    result.success("Data received in Android")
                } else {
                    result.notImplemented()
                    Log.d("MainActivity", "No data is received from flutter")
                }
            }
    }

    // Function to update repository state
    private fun updateRepository(repo: Repository) {
        repository = repo
    }
}

@Composable
fun MainScreen(repository: Repository?) {
    val context = LocalContext.current
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Spacer(modifier = Modifier.height(161.dp))
        Row(
            modifier = Modifier
                .padding(16.dp)
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.Center
        ) {
            Button(modifier = Modifier
                .width(156.dp)
                .height(44.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color.Black
                ),
                shape = RoundedCornerShape(10.dp),
                onClick = {
                    context.startActivity(
                        FlutterActivity.withCachedEngine(GHReposApplication.FLUTTER_ENGINE_NAME)
                            .build(context)
                    )
                }) {
                Text(text = stringResource(id = R.string.show_repo))
            }
        }
        Spacer(modifier = Modifier.height(16.dp))
        repository?.let {
            Column(
                modifier = Modifier
                    .padding(16.dp)
                    .fillMaxWidth()
            ) {
                it.repository?.fullName?.apply {
                    TitleText(text = this, fontWeight = FontWeight.Bold)
                    Spacer(modifier = Modifier.height(16.dp))
                }
                it.repository?.avatarUrl?.apply {
                    ImageBanner(url = this)
                    Spacer(modifier = Modifier.height(16.dp))
                }
                it.repository?.description?.apply {
                    TitleText(text = this, fontWeight = FontWeight.SemiBold)
                    Spacer(modifier = Modifier.height(16.dp))
                }
                if (!it.commits.isNullOrEmpty()){
                    CommitList(commits = it.commits)
                }
            }
        }
    }
}

@Preview(showBackground = true, device = Devices.PIXEL_4)
@Composable
fun MainScreenPreview() {
    GHRepositoriesTheme {
        MainScreen(null)
    }
}
