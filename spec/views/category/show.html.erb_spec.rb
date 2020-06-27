require 'rails_helper'

RSpec.describe 'category/show.html.erb', type: :system do
  before(:each) do
    @u = User.create(name: 'test')
    @c = Category.create(name: 'testcat')
  end
  context 'while visiting category show page' do
    it "it shows 'No Articles to show' when no articles exist" do
      visit category_path(@c)
      expect(page).to have_content('No Articles to show')
    end
    it 'shows article when available' do
      a = @u.articles.create(title: 'Myone', body: 'bodyyie', category_id: @c.id)
      visit category_path(@c)
      expect(page).to have_content(a.title)
    end
  end
end
