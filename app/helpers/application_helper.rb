module ApplicationHelper
  def page_title(title = '')
    base_title = 'Good Sleep Joy'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
