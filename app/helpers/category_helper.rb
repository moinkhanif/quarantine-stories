module CategoryHelper
  def show_articles
    if @articles.empty?
      content_tag :div, class: 'no-content' do
        concat(content_tag(:h1, class: 'category-title') do
          concat "Category: #{@category.name}"
        end)
        concat(content_tag(:h2) do
          'No Articles to show'
        end)
      end
    else
      @articles.map do |article|
        @cat_article = article
        content_tag :article do
          concat(content_tag(:figure) do
            article.image.exists? ? concat(image_tag(article.image.url)) : concat(image_tag('https://source.unsplash.com/random'))
          end)
          concat(content_tag(:div, class: 'article-content') do
            concat(content_tag(:div) do
              concat(content_tag(:h2, class: 'category-title') do
                concat @category.name
              end)
              concat(content_tag(:h2, class: 'article-title') do
                concat article.title
              end)
              concat(content_tag(:h4, class: 'author') do
                concat "by #{article.user.name.capitalize}"
              end)
              concat(content_tag(:p, class: 'article-body') do
                concat article.body.truncate(300)
              end)
              votes_button
            end)
          end)
        end
      end.join.html_safe
    end
  end

  def votes_button
    concat(content_tag(:div, class: 'article-votes') do
      article = @cat_article
      if logged_in?
        vote = article.votes.find_by(user: current_user)
        if vote
          concat(button_to('unvote', article_vote_path(article_id: article.id), method: :delete))
        else
          concat(button_to('vote', article_vote_index_path(article_id: article.id)))
        end
      else
        concat(button_to('vote', {}, { disabled: true }))
      end
      concat(content_tag(:span) do
        article.votes.size == 1 ? concat('1 vote') : concat("#{article.votes.size} votes")
      end)
    end)
  end
end
