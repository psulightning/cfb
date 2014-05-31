# To change this template, choose Tools | Templates
# and open the template in the editor.

module CommentsControllerPatch
  extend ActiveSupport::Concern
   
  included do
    remove_method :comment_params
    protected
    def comment_params
      params.fetch(:comment, {}).permit(:author_id, :content)
    end
  end
end
