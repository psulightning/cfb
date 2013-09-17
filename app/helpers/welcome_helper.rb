module WelcomeHelper
    def image_links(files)
      content = []
      files.each{|f|
        content << image_tag(f.file.url)
      }
      (content.join("\n")).html_safe
    end
end
