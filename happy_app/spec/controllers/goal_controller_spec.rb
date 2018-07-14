require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe "GET #new" do
    it "render goal input page" do
      get :new
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do 
      it "saves a goal to database" do
        post :create, params: {goal: {user_id: 1, description: '123456'}}
        goal = Goal.last
        
        expect(goal.description).to eq('123456')
        expect(response).to redirect_to(user_url(goal.user_id))
      end
    end
    
    context "without valid params" do
      it "doesn't save a user to database" do
        post :create, params: {user: {user_id: 1}}
        expect(response).to redirect_to(new_goal_url)
        expect(flash[:errors]).not_to be_empty
      end
    end
  end
  
  describe "DELETE #destroy" do
    it "deletes a goal" do
      goal = Goal.find_by(id: params[:id])
    end
  end
end