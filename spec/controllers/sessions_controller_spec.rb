require 'spec_helper'

describe SessionsController do
  describe "POST #create" do
    before do
      @user = FactoryGirl.create(:user, password: "secret123")
    end

    it "redirects to dashboard for correct credentials" do
      post :create, :email => @user.email, :password => "secret123"
      expect(response).to redirect_to(dashboard_path)
    end

    it "renders login form for wrong credentials" do
      post :create, :email => @user.email, :password => "WrongPassword"
      expect(response).to render_template("users/new_login")
    end
  end
end
