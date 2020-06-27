require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :system do
  before do
    @u = User.create(name: 'test')
    @c = Category.create(name: 'testcat')
    @a = @u.articles.create(title: 'Myone', body: 'bodyyie', category_id: @c.id)
  end
  context 'while visiting the homepage' do
    it 'contains category links' do
      Category.create(name: 'Myone')
      visit root_path
      expect(page).to have_content(Category.first.name)
    end
    it 'contains article title with highest votes' do
      @a.votes.create(user_id: @u.id)
      a = Article.find(Vote.group(:article_id).count.max_by { |_a, v| v }.first)
      visit root_path
      expect(page).to have_content(a.title)
    end
  end
end
