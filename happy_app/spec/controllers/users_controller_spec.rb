require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "renders index" do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET #new" do
    it "renders new where users can sign up" do
      get :new
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do 
      it "saves a user to database" do
        post :create, params: {user: {username: 'c', password: '123456'}}
        user = User.find_by(username: 'c')
        expect(session[:session_token]).to eq(user.session_token)
        expect(response).to redirect_to(user_url(user))
      end
    end
    
    context "without valid params" do
      it "doesn't save a user to database" do
        post :create, params: {user: {username: "c", password: "12345"}}
        expect(response).to render_template(:new)
        expect(flash[:errors]).not_to be_empty
      end
    end
    
  end
  
end