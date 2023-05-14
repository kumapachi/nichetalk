require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @relationship = FactoryBot.build(:relationship)
  end
  context 'relationshipが機能しないとき' do
    it 'followingが紐付いていないと保存できない' do
      @relationship.following = nil
      @relationship.valid?
      expect(@relationship.errors.full_messages).to include('Following must exist')
    end
    it 'followerが紐付いていないと保存できない' do
      @relationship.follower = nil
      @relationship.valid?
      expect(@relationship.errors.full_messages).to include('Follower must exist')
    end
  end
end

# bundle exec rspec spec/models/relationship_spec.rb