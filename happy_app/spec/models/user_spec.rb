require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "vaidations" do
    subject(:dork) { User.new(username: "Viktornick", password: "thebestpassword")}
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:password).is_at_least(6)}
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    
    it "does not save passwords" do 
      u = User.find_by(username: "Viktornick")
      expect(u.password).to be_nil
    end
  end
  
  describe "class methods" do
    prod =  User.create(username: "Viktornick", password: "thebestpassword")
    it "should generate a session_token" do
      st = User.generate_session_token
      expect(st).not_to be_nil
    end
    
    it "should return a user with correct credentials" do
      u = User.find_by_credentials("Viktornick", "thebestpassword")
      expect(u).not_to be_nil
    end
    
    it "should return nil if user doesn't exist" do 
      u = User.find_by_credentials("Nictor", "theworstpassword")
      expect(u).to be_nil
   end
   
    
  end
end
