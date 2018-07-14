require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'validations' do 
    # subject(:user) { User.new(username: "Grumpy McGrumpelstein", password: "shlomo")}
    let(:goal) { Goal.new(user_id: 1, description: "Keep kids from catchin' me pot o' gold.")}
    it 'Public should be true to start' do
      expect(goal.public).to be true
    end
    it 'Complete should be false to start' do
      expect(goal.completed).to be false
    end
      it {should validate_presence_of(:user_id)}
      it {should validate_presence_of(:description)}
  end 
  
  describe 'associations' do
    it {should belong_to(:user)}
  end
  
  describe 'instance methods' do
    let(:goal) { Goal.new(user_id: 1, description: "Keep kids from catchin' me pot o' gold.")}
    
    it "changes publicity status of a goal" do
      goal.change_publicity
      expect(goal.public).to be false
    end
    
    it "changes completion status of a goal" do
      goal.change_goal_status
      expect(goal.completed).to be true
    end
  end
end
