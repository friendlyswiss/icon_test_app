module ApplicationHelper
  
  # Returns the full title on a per-page basis
  def full_title(page_title)
    base_title = "Icon Recognition Test"
    if page_title == 'Home'
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
