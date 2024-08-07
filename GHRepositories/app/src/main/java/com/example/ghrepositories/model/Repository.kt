package com.example.ghrepositories.model

import com.google.gson.annotations.SerializedName

data class Repository(

	@field:SerializedName("commits")
	val commits: List<CommitsItem?>? = null,

	@field:SerializedName("repository")
	val repository: Repository? = null,

	@field:SerializedName("avatarUrl")
	val avatarUrl: String? = null,

	@field:SerializedName("name")
	val name: String? = null,

	@field:SerializedName("fullName")
	val fullName: String? = null,

	@field:SerializedName("description")
	val description: String? = null,

	@field:SerializedName("id")
	val id: Int? = null,

	@field:SerializedName("nodeId")
	val nodeId: String? = null
)

data class CommitsItem(

	@field:SerializedName("id")
	val id: Int? = null,

	@field:SerializedName("repositoryName")
	val repositoryName: String? = null,

	@field:SerializedName("message")
	val message: String? = null,

	@field:SerializedName("sha")
	val sha: String? = null,

	@field:SerializedName("nodeId")
	val nodeId: String? = null,

	@field:SerializedName("url")
	val url: String? = null,

	@field:SerializedName("repositoryNodeId")
	val repositoryNodeId: String? = null,

	@field:SerializedName("commitDate")
	val commitDate: Long? = null
)
