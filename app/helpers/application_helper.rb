module ApplicationHelper
  def loggedin_link_logic
    if logged_in?
      concat(content_tag(:li, class: 'multi-li') do
        concat(link_to(current_user.name.capitalize, root_path))
        concat(tag.span(image_tag('down-arrow.svg', alt: 'down arrow', class: 'down-arrow')))
        concat(content_tag(:ul) do
          concat(tag.li(link_to('Create Article', new_article_path)))
          concat(tag.li(link_to('Create Category', new_category_path)))
        end)
      end)
      tag.li link_to 'LOGOUT', logout_path
    else
      concat(tag.li(link_to('SIGN IN |', login_path)))
      tag.li link_to 'SIGN UP', signup_path
    end
  end

  def flash_info
    unless flash.empty?
      flash.map do |_name, msg|
        if notice.present?
          content_tag :div, class: 'notice' do
            tag.p msg
          end
        elsif alert.present?
          content_tag :div, class: 'alert' do
            tag.p msg
          end
        end
      end.join.html_safe
    end
  end

  def category_nav_links
    unless five_categories.empty?
      concat(five_categories.map do |cat|
        content_tag(:li) do
          link_to cat.name.upcase, category_path(cat)
        end
      end.join.html_safe)
      tag.li link_to 'ALL CATEGORIES', '#' if all_categories.size > 5
    end
  end
end
