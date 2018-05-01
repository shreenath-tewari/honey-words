module ApplicationHelper

  def full_title(page_title)
    base_title = "Sample App"
    if page_title.empty?
      return title
    else
      title = page_title + " | " + base_title
    end
    title
  end



end
