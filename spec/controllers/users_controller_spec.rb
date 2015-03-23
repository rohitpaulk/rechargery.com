require 'spec_helper'

describe UsersController,:type => :controller do
  describe "GET #login" do
    context "if user is logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "redirects to dashboard" do
        get :login
        expect(response).to redirect_to(url_for({:controller => "users",:action => "dashboard",:only_path => true}))
      end
    end
    context "if user is not logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end

      it "shows login/signup page" do
        get :login
        expect(response).to be_success
        expect(response.status).to eq(200)
        expect(response).to render_template("login")
      end
    end
  end

  describe "POST #createuser" do
    context "with valid attributes" do
      it "creates a new user" do
        params = {name: "Rohit", email: "rohitkuruvilla@yahoo.co.in",phone: "9501499829",phone_operator: 1,password: "abcd",password_confirmation: "abcd"}
        post :createuser, params
        expect(User.last.email).to eq("rohitkuruvilla@yahoo.co.in")
      end

      it "redirects to dashboard" do
        params = {name: "Rohit", email: "rohitkuruvilla@yahoo.co.in",phone: "9501499829",phone_operator: 1,password: "abcd",password_confirmation: "abcd"}
        post :createuser, params
        expect(response).to redirect_to(url_for({:controller => "users",:action => "dashboard",:only_path => true}))
      end
    end
    context "with invalid attributes" do
      it "does not save new user" do
        params = {name: "Rohit", email: "rohitkuruvilla@yahoo.co.in",phone: "9501499829",password: "abcd",password_confirmation: "abcde"}
        post :createuser, params
        expect(User.count).to eq(0)
      end
    end
  end

  describe "GET #edit" do
    context "user is logged in" do
      before do
        testuser = FactoryGirl.create(:user)
        ApplicationController.any_instance.stub(:current_user).and_return(testuser)
      end

      it "renders edit template" do
        get :edit
        expect(response).to render_template('edit')
        expect(assigns[:user]).to_not eq(nil)
      end
    end

    context "user is not logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end
      it "redirects to login page" do
        get :edit
        expect(response).to redirect_to(new_login_path(:return_to => edit_profile_path))
      end
    end
  end

  describe "GET #changepassword" do
    context "user is logged in" do
      before do
        testuser = FactoryGirl.create(:user)
        ApplicationController.any_instance.stub(:current_user).and_return(testuser)
      end

      it "renders changepassword template" do
        get :changepassword
        expect(response).to render_template('changepassword')
        expect(assigns[:user]).to_not eq(nil)
      end
    end

    context "user is not logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end
      it "redirects to login page" do
        get :changepassword
        expect(response).to redirect_to(new_login_path(:return_to => changepassword_path))
      end
    end
  end

  describe "POST #updatepassword" do
    before do
      @user = FactoryGirl.create(:user)
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
    end

    context "with valid attributes" do
      it "updates current user" do
        params = { password: "abcd3", password_confirmation: "abcd3" }
        post :updatepassword, params
        expect(@user.check_password("abcd3")).to be_true
      end

      it "redirects to dashboard" do
        params = { password: "abcd3", password_confirmation: "abcd3" }
        post :updatepassword, params
        expect(response).to redirect_to(url_for({:controller => "users", :action => "dashboard", :only_path => true}))
      end
    end

    context "with invalid attributes" do
      it "does not update current user" do
        params = { password: "abcd", password_confirmation: "abcd3" }
        post :updatepassword, params
        expect(response).to render_template('changepassword')
      end
    end
  end

  describe "GET #forgotpassword" do
    context "if user is logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "redirects to dashboard" do
        get :forgotpassword
        expect(response).to redirect_to(url_for({ :controller => "users", :action => "dashboard", only_path: true }))
      end
    end

    context "if user is not logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end

      it "shows forgotpassword template" do
        get :forgotpassword
        expect(response).to render_template('forgotpassword')
      end
    end
  end
  describe "POST #resetpassword" do
    before do
      @user = FactoryGirl.create(:user, password: "abcd")
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
    end

    it "updates current user" do
      params = { email: @user.email }
      post :resetpassword, params
      expect(@user.reload.check_password("abcd")).to be_false
    end

    it "redirects to dashboard" do
      params = { email: @user.email }
      post :resetpassword, params
      expect(response).to redirect_to(url_for({controller: "users", action: "login", only_path: true}))
    end
  end

  describe "GET #destroy" do
    context "user not logged in" do
      before do
        FactoryGirl.create(:user)
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end

      it "doesn't destroys user" do
        get :destroy
        expect(User.count).to eq(1)
      end
    end

    context "user is logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "destroys user" do
        get :destroy
        expect(User.count).to eq(0)
      end

      it "redirects to login" do
        get :destroy
        expect(response).to redirect_to(url_for({:controller => "users", :action => "login", :only_path => true}))
      end
    end
  end

  describe "POST #update" do
    before do
      @user = FactoryGirl.create(:user, password: "abcd")
      ApplicationController.any_instance.stub(:current_user).and_return(@user)
    end

    context "with valid attributes" do
      it "updates current user" do
        params = { name: "Example", phone: "9501499823", phone_operator: 1}
        post :update, params
        expect(@user.name).to eq("Example")
      end

      it "redirects to dashboard" do
        params = { name: "Example", phone: "9501499823", phone_operator: 1}
        post :update, params
        expect(response).to redirect_to(url_for({:controller => "users", :action => "dashboard", :only_path => true}))
      end
    end

    context "with invalid attributes" do
      it "does not update current user" do
        params = { name: "Example", phone: "95014998", phone_operator: 1}
        post :update, params
        expect(response).to render_template('edit')
      end
    end
  end

  describe "GET #dashboard" do
    context "if user is logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "renders dashboard" do
        get :dashboard
        expect(response).to render_template('dashboard')
      end
    end
    context "if user is not logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end

      it "shows login/signup page" do
        get :dashboard
        expect(response).to redirect_to(new_login_path(:return_to => dashboard_path))
      end
    end
  end

  describe "GET #show" do
    context "if user is logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "renders show" do
        get :show
        expect(assigns[:current_user]).to_not be_nil
        expect(response).to render_template('show')
      end
    end
    context "if user is not logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end

      it "shows login/signup page" do
        get :show
        expect(response).to redirect_to(new_login_path(:return_to => profile_path))
      end
    end
  end
end
