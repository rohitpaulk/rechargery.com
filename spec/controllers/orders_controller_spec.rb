require 'spec_helper'

describe OrdersController,:type => :controller do
  # describe "GET #edit" do
  #   context "if user is logged in" do
  #     before do
  #       testorder=FactoryGirl.create(:order)
  #       ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
  #     end
  #     it "renders edit view" do
  #       get :edit, id: Order.first.id
  #       expect(response).to render_template('edit')
  #     end
  #   end
  #   context "if user is not logged in" do
  #     before do
  #       ApplicationController.any_instance.stub(:current_user).and_return(nil)
  #       FactoryGirl.create(:order)
  #     end
  #     it "shows login/signup page" do
  #       get :edit, id: Order.first.id
  #       expect(response).to be_redirect
  #       # expect(response.location).to include("login")
  #       expect(response).to redirect_to(new_login_path(:return_to => edit_order_path(Order.first.id)))
  #     end
  #   end
  # end

  # describe "POST #update" do
  #   context "with valid attributes" do
  #     it "updates current order" do
  #       testorder = FactoryGirl.create(:order,:shopname => 1, :ordertotal => 1234)
  #       ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
  #       params = {id: testorder.id,orderid: "13141231",productname: "Sample Desc",emailused: "abcd@example.com"}
  #       post :update, params
  #       testorder.reload
  #       expect(testorder.orderid).to eq("13141231")
  #     end
  #     it "redirects to orders page" do
  #       testorder = FactoryGirl.create(:order)
  #       ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
  #       params = {id: testorder.id,orderid: "13141231",productname: "Sample Desc",emailused: "abcd@example.com"}
  #       post :update, params
  #       expect(response).to redirect_to(url_for({:controller => "orders",:action => "index",:only_path => true}))
  #     end
  #   end
  #   context "with invalid attributes" do
  #     it "does not update current user" do
  #       testorder = FactoryGirl.create(:order,:shopname => 1, :ordertotal => 1234)
  #       ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
  #       params = {id: testorder.id,orderid: "",productname: "Sample Desc",emailused: "abcd@example.com"}
  #       post :update, params
  #       #expect(response).to redirect_to(url_for({:controller => "orders",:action => "index",:only_path => true}))
  #       expect(response).to render_template('edit')
  #     end
  #   end
  # end

  describe "GET #newamazon" do
    context "if user is logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
      end
      it "renders edit view" do
        get :newamazon
        expect(response).to render_template('newamazon')
      end
    end
    context "if user is not logged in" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(nil)
      end
      it "shows login/signup page" do
        get :newamazon
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe "POST #createamazon" do
    context "with valid attributes" do
      it "updates current order" do
        FactoryGirl.create(:amazon_store)
        testuser = FactoryGirl.create(:user)
        ApplicationController.any_instance.stub(:current_user).and_return(testuser)
        params = {orderid: "13141231",productname: "Sample Desc",emailused: "abcd@example.com",ordertotal: 9000}
        post :createamazon, params
        expect(testuser.orders.count).to eq(1)
      end
      it "redirects to dashboard" do
        FactoryGirl.create(:amazon_store)
        testuser = FactoryGirl.create(:user)
        ApplicationController.any_instance.stub(:current_user).and_return(testuser)
        params = {orderid: "13141231",productname: "Sample Desc",emailused: "abcd@example.com",ordertotal: 9000}
        post :createamazon, params
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "with invalid attributes" do
      it "does not update current user" do
        FactoryGirl.create(:amazon_store)
        testuser = FactoryGirl.create(:user)
        ApplicationController.any_instance.stub(:current_user).and_return(testuser)
        params = {orderid: "",productname: "Sample Desc",emailused: "abcd@example.com"}
        post :createamazon, params
        expect(response).to render_template('newamazonretry')
      end
    end
  end

  # describe "GET #show" do
  #   context "with valid order id" do
  #     before do
  #       testorder = FactoryGirl.create(:order)
  #       ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
  #     end
  #     it "renders show template" do
  #       get :show, id: Order.first.id
  #       expect(response).to render_template('show')
  #       expect(assigns[:order]).to eq(Order.first)
  #     end
  #   end
  #   context "with invalid order id" do
  #     before do
  #       testorder = FactoryGirl.create(:order)
  #       ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
  #     end
  #     it "redirects to dashboard" do
  #       get :show, id: 5
  #       expect(response).to redirect_to(url_for({:controller => "users",:action => "dashboard",:only_path => true}))
  #     end
  #   end
  # end

  # describe "GET #index" do
  #   context "if user is logged in" do
  #     before do
  #       testorder=FactoryGirl.create(:order)
  #       ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
  #     end
  #     it "renders index view" do
  #       get :index
  #       expect(response).to render_template('index')
  #     end
  #   end
  #   context "if user is not logged in" do
  #     before do
  #       ApplicationController.any_instance.stub(:current_user).and_return(nil)
  #       FactoryGirl.create(:order)
  #     end
  #     it "shows login/signup page" do
  #       get :index
  #       expect(response).to redirect_to(new_login_path(:return_to => orders_path))
  #     end
  #   end
  # end
end
