require 'rails_helper'

RSpec.describe User, type: :model do
  context 'while creating a user' do
    it 'returns true when saving valid user' do
      a = User.new(name: 'moin')
      expect(a.save).to eql(true)
    end
    it 'returns false when saving invalid user' do
      b = User.new
      expect(b.save).to eql(false)
    end
    it 'returns false when user already exists' do
      u1 = User.create(name: 'testie')
      u2 = User.new(name: u1.name)
      expect(u2.valid?).to eql(false)
    end
  end
end
