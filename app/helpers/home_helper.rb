module HomeHelper
  def front_home
    if !@categories.empty? and @featured_article
      content_tag(:article, style: "background: linear-gradient(to bottom,rgba(0, 0, 0, 0.25), rgb(0, 0, 0, 0.9) 100%), url(#{@featured_article.image.exists? ? @featured_article.image.url : 'https://source.unsplash.com/random'}) no-repeat center;") do
        content_tag(:h2,class: "article-title") do
          @featured_article.title
        end
      end
    else
      content_tag(:article, style: "background: linear-gradient(to bottom,rgba(0, 0, 0, 0.25), rgb(0, 0, 0, 0.9) 100%), url('https://source.unsplash.com/random') no-repeat center;"
         ) do
        content_tag(:h2, class: "article-title") do
          "No articles wth votes found"
        end
      end
    end
  end
  def home_categories
    @categories.map do |category|
      article = category.articles.sort_by(&:created_at).last
      content_tag(:article, style:"background: linear-gradient(to bottom,rgba(0, 0, 0, 0.25), rgb(0, 0, 0, 0.9) 100%), url(#{(article and article.image.exists?) ? article.image.url : "https://source.unsplash.com/random" }) no-repeat center;") do
        concat(content_tag(:h2) do
          link_to category.name, category_path(category)
        end)
        if article
          concat(content_tag(:h3) do
            article.title
          end)
        end
      end
    end.join.html_safe
  end
end
