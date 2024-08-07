package com.example.ghrepositories.components

import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.ghrepositories.model.CommitsItem

@Composable
fun CommitItem(commit: CommitsItem?) {
    // Display commit message, handle null values gracefully
    Text(
        text = commit?.message ?: "No message",
        modifier = Modifier.padding(12.dp),
        style = MaterialTheme.typography.bodyMedium
    )
}