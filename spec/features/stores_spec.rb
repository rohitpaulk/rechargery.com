require 'spec_helper'

feature 'Browse Stores' do
  before do
    Rails.application.load_seed
    @user = FactoryGirl.create(:user, password: "abcd")
    sign_in_with(@user.email, "abcd")
  end

  scenario 'clicking a store takes to stores#visitstore' do
    visit '/'
    click_link 'Stores'
    expect(page.current_path).to eq('/stores')
    click_link 'flipkart'
    expect(page.current_path).to eq('/stores/flipkart/go')
  end

  scenario 'clicking on amazon redirects to amazon/new' do
    visit '/'
    click_link 'Stores'
    expect(page.current_path).to eq('/stores')
    click_link 'amazon'
    expect(page.current_path).to eq('/orders/newamazon')
  end
end

feature 'Visit Stores' do
  before do
    Rails.application.load_seed
    @user = FactoryGirl.create(:user, password: "abcd")
    sign_in_with(@user.email, "abcd")
  end
end
