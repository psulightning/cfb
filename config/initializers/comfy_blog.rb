ComfyBlog.configure do |config|
  
  # Number of posts per page. Default is 10
  #   config.posts_per_page = 10
  
  # Comments can be automatically approved/published by changing this setting
  # Default is false.
  config.auto_publish_comments = true
  
end
Comfy::Admin::Blog::PostsController.send(:include, AdminPostsControllerPatch)
Comfy::Blog::PostsController.send(:include, PostsControllerPatch)
Comfy::Blog::CommentsController.send(:include, CommentsControllerPatch)
Comfy::Blog::Comment.send(:include, CommentPatch)
Comfy::Blog::Post.send(:include,PostPatch)