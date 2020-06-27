require 'rails_helper'

RSpec.describe Vote, type: :model do
  before(:each) do
    @u = User.create(name: 'test')
    @c = Category.create(name: 'testcat')
    @a = @u.articles.create(title: 'Myone', body: 'bodyyie', category_id: @c.id)
  end
  context 'while creating new votes' do
    it 'returns true when vote is valid' do
      v = Vote.new(user_id: @u.id, article_id: @a.id)
      expect(v.valid?).to be(true)
    end
    it 'returns false when vote invalid' do
      v = Vote.new
      expect(v.valid?).to be(false)
    end
  end
end
