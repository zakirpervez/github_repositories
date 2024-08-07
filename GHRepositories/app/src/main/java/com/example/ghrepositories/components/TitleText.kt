package com.example.ghrepositories.components

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

@Composable
fun TitleText(text: String, fontWeight: FontWeight) {
    Text(
        text = text,
        color = Color.Black,
        fontWeight = fontWeight,
        fontSize = 24.sp
    )
}