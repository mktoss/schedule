require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'can save' do
      it 'nameが12字以内' do
        expect(build(:user, name: 'aaaaaaaaaaaa')).to be_valid
      end
    end

    context 'can not save' do
      it 'nameが13字以上' do
        user = build(:user, name: 'aaaaaaaaaaaaa')
        user.valid?
        expect(user.errors[:name]).to include("is too long (maximum is 12 characters)")
      end

      it 'nameが重複' do
        another_user = create(:user)
        user = build(:user)
        user.valid?
        expect(user.errors[:name]).to include("has already been taken")
      end

      it 'nameが空' do
        user = build(:user, name: '')
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
    end
  end
end
