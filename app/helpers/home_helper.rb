module HomeHelper
  def front_home
    if !@categories.empty? and @featured_article
      content_tag(:article, style: article_background_styles(@featured_article)) do
        content_tag(:h2, class: 'article-title') do
          @featured_article.title
        end
      end
    else
      content_tag(:article, style: article_background_styles) do
        content_tag(:h2, class: 'article-title') do
          'No articles wth votes found'
        end
      end
    end
  end

  def home_categories
    @categories.map do |category|
      article = category.articles.max_by(&:created_at)
      content_tag(:article, style: article_background_styles(article)) do
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

  def article_background_styles(article = nil)
    style = 'background: linear-gradient(to bottom,rgba(0, 0, 0, 0.25), rgb(0, 0, 0, 0.9) 100%), '
    style + if article
              "url(#{article_images(article)}) no-repeat center;"
            else
              "url('https://source.unsplash.com/random/?happy') no-repeat center;"
            end
  end

  def article_images(article)
    article.image.exists? ? article.image.url : 'https://source.unsplash.com/random/?happy'
  end
end
