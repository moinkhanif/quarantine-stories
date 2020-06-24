require 'rails_helper'

RSpec.describe Article, type: :model do
  before(:each) do
    @u = User.create(name: 'test')
    @c = Category.create(name: 'testcat')
  end
  context 'while creating articles' do
    it 'returns true when article is valid' do
      a = Article.new(title: 'Myone', body: 'bodyyie', category_id: @c.id, user_id: @u.id)
      expect(a.valid?).to be(true)
    end
    it 'returns false when article is invalid' do
      a = Article.new(title: 'omg')
      expect(a.valid?).to be(false)
    end
  end
  context 'when checking article image' do
    it 'returns true when image given' do
      a = Article.create(title: 'Myone', body: 'bodyyie', category_id: @c.id, user_id: @u.id)
      file = File.new("#{Rails.root}/app/assets/images/laptop-ph1.jpg")
      a.image = file
      expect(a.image.exists?).to be(false)
    end
    it 'returns false when image not given' do
      a = Article.create(title: 'Myone', body: 'bodyyie', category_id: @c.id, user_id: @u.id)
      expect(a.image.exists?).to be(false)
    end
  end
end
