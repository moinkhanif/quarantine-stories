module ApplicationHelper
  def loggedin_link_logic
    if logged_in?
      concat(content_tag(:li, class: "multi-li") do
        concat(link_to current_user.name.capitalize,  root_path)
        concat(tag.span image_tag("down-arrow.svg", alt: "down arrow",class: "down-arrow"))
        concat(content_tag(:ul) do
          concat(tag.li link_to "Create Article", new_article_path)
          concat(tag.li link_to "Create Category", new_category_path)
        end)
      end)
      tag.li link_to "LOGOUT", logout_path
    else
      concat(tag.li link_to "SIGN IN |", login_path)
      tag.li link_to "SIGN UP", signup_path
    end
  end
  def flash_info
    flash.map do |name, msg|
      if notice.present?
        content_tag :div, class: "notice" do
          tag.p msg
        end
      elsif alert.present?
        content_tag :div, class: "alert" do
          tag.p msg
        end
      end
    end.join.html_safe if !flash.empty?
  end
  def category_nav_links
    if !five_categories.empty?
      concat(five_categories.map do |cat|
        content_tag(:li) do
          link_to cat.name.upcase, category_path(cat)
        end
      end.join.html_safe)
      if all_categories.size > 5
        tag.li link_to "ALL CATEGORIES", "#"
      end
    end
  end
end
