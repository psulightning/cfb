class AddIsMenuBarToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :is_menu_bar, :boolean, :after => :is_published, :default => 0
  end
end
