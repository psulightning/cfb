class UpgradeComfyBlog1120 < ActiveRecord::Migration
  def change
    rename_table :blog_comments, :comfy_blog_comments
    rename_table :blog_posts, :comfy_blog_posts
    rename_table :blog_taggings, :comfy_blog_taggings
    rename_table :blog_tags, :comfy_blog_tags
    rename_table :blogs, :comfy_blogs
  end
end
