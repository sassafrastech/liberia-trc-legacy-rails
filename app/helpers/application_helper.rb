# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def document_link(name)
    pub_path = "/resources/documents/#{name}.pdf"
    loc_path = "#{RAILS_ROOT}/public#{pub_path}"
    size = (File.size(loc_path)/1024).floor
    link_to("Download (#{size}kb)", pub_path)
  end
end
