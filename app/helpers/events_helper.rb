module EventsHelper
  def cleanup_description(str)
    str = strip_tags(str)
    str.gsub!("&amp;", "&")
    str.gsub!("&nbsp;", "")
    truncate(str, length: 75)
  end
end
