package com.example.ghrepositories.components

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.ghrepositories.model.CommitsItem

@Composable
fun CommitList(commits: List<CommitsItem?>?) {
    // Display an empty list message if commits is null or empty
    if (commits.isNullOrEmpty()) {
        Text(
            text = "No commits available",
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            style = MaterialTheme.typography.bodyLarge
        )
    } else {
        LazyColumn(
            modifier = Modifier.fillMaxSize()
        ) {
            items(commits.size) { position ->
                CommitItem(commit = commits[position])
            }
        }
    }
}