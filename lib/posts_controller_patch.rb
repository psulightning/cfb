module PostsControllerPatch
  extend ActiveSupport::Concern

  included do
    helper PostsHelper
    remove_method :show
    def show
      @post = if params[:slug] && params[:year] && params[:month]
        @blog.posts.published.where(:year => params[:year], :month => params[:month], :slug => params[:slug]).first!
      else
        @blog.posts.published.where(:slug => params[:slug]).first!
      end
      @comment = Comfy::Blog::Comment.new({post_id: @post.id})

    rescue ActiveRecord::RecordNotFound
      render :cms_page => '/404', :status => 404
    end
  end
end
