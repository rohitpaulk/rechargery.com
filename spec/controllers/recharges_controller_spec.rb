# require 'spec_helper'

# describe RechargesController do
#   describe "GET #new" do
#     context "logged in" do
#       it "renders new template" do
#         testorder = FactoryGirl.create(:order)
#         ApplicationController.any_instance.stub(:current_user).and_return(testorder.user)
#         get :new, orderid: testorder.id
#         expect(response).to render_template('new')
#       end
#     end
#     context "not logged in" do
#       it "redirects to login" do
#         testorder = FactoryGirl.create(:order)
#         ApplicationController.any_instance.stub(:current_user).and_return(nil)
#         get :new, orderid: testorder.id
#         expect(response).to redirect_to(new_login_path(:return_to => new_recharge_path))
#       end
#     end
#   end
#   describe "GET #create" do
#     context "with valid attributes" do
#       it "creates new recharge" do
#         testorder = FactoryGirl.create(:order)
#         params = {orderid:testorder.id,phonenumber:"9501499829",phone_operator: 1}
#         get :create, params
#         expect(Recharge.count).to eq(1)
#       end
#       it "redirects to dashboard" do
#         testorder = FactoryGirl.create(:order)
#         params = {orderid:testorder.id,phonenumber:"9501499829",phone_operator: 1}
#         get :create, params
#         expect(response).to redirect_to(url_for({:controller => "users",:action => "dashboard",:only_path => true}))
#       end
#     end
#     context "with invalid attributes" do
#       it "doesn't create new recharge" do
#         testorder = FactoryGirl.create(:order)
#         params = {orderid:testorder.id,phonenumber:"950149982",phone_operator: 1}
#         get :create, params
#         expect(Recharge.count).to eq(0)
#       end
#       it "renders new template again" do
#         testorder = FactoryGirl.create(:order)
#         params = {orderid:testorder.id,phonenumber:"950149982",phone_operator: 1}
#         get :create, params
#         expect(response).to render_template('new')
#       end
#     end
#   end

#   describe "GET #edit" do
#     context "with valid recharge ID" do
#       it "renders edit template" do
#         testrecharge = FactoryGirl.create(:recharge)
#         ApplicationController.any_instance.stub(:current_user).and_return(testrecharge.order.user)
#         params = {id:testrecharge.id}
#         get :edit, params
#         expect(response).to render_template('edit')
#       end
#     end
#     context "with invalid recharge ID" do
#       it "redirects to orders page" do
#         testrecharge = FactoryGirl.create(:recharge)
#         ApplicationController.any_instance.stub(:current_user).and_return(testrecharge.order.user)
#         params = {id: 5}
#         get :edit, params
#         expect(response).to redirect_to(url_for({:controller => "orders",:action => "index",:only_path => true}))
#       end
#     end
#   end

#   describe "POST #update" do
#     context "with valid attributes" do
#       it "updates recharge" do
#         testrecharge = FactoryGirl.create(:recharge)
#         params = {id: testrecharge.id,phonenumber: "9501499823",phone_operator: 1}
#         post :update, params
#         testrecharge.reload
#         expect(testrecharge.phonenumber).to eq("9501499823")
#       end
#       it "redirects to orders index" do
#         testrecharge = FactoryGirl.create(:recharge)
#         params = {id: testrecharge.id,phonenumber: "9501499829",phone_operator: 1}
#         post :update, params
#         expect(response).to redirect_to(url_for({:controller => "recharges",:action => "show", :id => testrecharge.id ,:only_path => true}))
#       end
#     end
#     context "with invalid attributes" do
#       it "doesn't updates recharge" do
#         testrecharge = FactoryGirl.create(:recharge)
#         params = {id: testrecharge.id,phonenumber: "95014993",phone_operator: 1}
#         post :update, params
#         testrecharge.reload
#         expect(testrecharge.phonenumber).to eq("9501499829")
#       end
#       it "redirects to orders index" do
#         testrecharge = FactoryGirl.create(:recharge)
#         params = {id: testrecharge.id,phonenumber: "950149982",phone_operator: 1}
#         post :update, params
#         expect(response).to render_template('edit')
#       end
#     end
#   end

#   describe "GET #show" do
#     context "with valid recharge ID" do
#       it "renders show template" do
#         testrecharge = FactoryGirl.create(:recharge)
#         ApplicationController.any_instance.stub(:current_user).and_return(testrecharge.order.user)
#         params = {id:testrecharge.id}
#         get :show, params
#         expect(response).to render_template('show')
#       end
#     end
#     context "with invalid recharge ID" do
#       it "redirects to orders page" do
#         ApplicationController.any_instance.stub(:current_user).and_return(FactoryGirl.create(:user))
#         get :show, id: 5
#         expect(response).to redirect_to(orders_path)
#       end
#     end
#   end
# end
