require 'spec_helper'

describe StoresController do
  before do
    Rails.application.load_seed
  end

  describe "GET /stores" do
    it "assigns categories to correct value" do
      get :index
      expect(assigns(:categories)).to eq(Category.all)
    end
  end

  describe "GET /stores/:slug" do
    it "fetches proper store" do
      get :show, slug: 'flipkart'
      flipkart = Store.find_by_slug('flipkart')
      expect(assigns(:store)).to eq(flipkart)
    end

    it "redirects to stores#index if store isn't valid" do
      get :show, slug: 'invalid'
      expect(response).to redirect_to(stores_path)
    end
  end

  describe "GET /stores/:slug/visited" do
    it "fetches proper store" do
      get :visited, slug: 'flipkart'
      flipkart = Store.find_by_slug('flipkart')
      expect(assigns(:store)).to eq(flipkart)
    end

    it "redirects to stores#index if store isn't valid" do
      get :visited, slug: 'invalid'
      expect(response).to redirect_to(stores_path)
    end
  end

  describe "GET /stores/:slug/go" do
    it "fetches proper store" do
      get :visitstore, slug: 'flipkart'
      flipkart = Store.find_by_slug('flipkart')
      expect(assigns(:store)).to eq(flipkart)
    end

    it "redirects to stores#index if store isn't valid" do
      get :visitstore, slug: 'invalid'
      expect(response).to redirect_to(stores_path)
    end

    it "redirects to amazon if slug is amazon" do
      get :visitstore, slug: 'amazon'
      expect(response).to redirect_to(newamazon_path)
    end

    it "assigns redirecturl variable properly" do
      get :visitstore, slug: 'flipkart'
      expect(assigns(:redirecturl)).to eq("http://www.flipkart.com?affid=rohitkuruv&affExtParam1=1")
    end
  end
end
