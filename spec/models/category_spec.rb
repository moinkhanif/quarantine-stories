require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'while creating new category' do
    it 'returns true when valid' do
      c = Category.new(name: 'samplecat')
      expect(c.valid?).to be(true)
    end
    it 'returns false when invalid' do
      c = Category.new
      expect(c.valid?).to be(false)
    end
  end
end
