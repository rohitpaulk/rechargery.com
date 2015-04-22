Master::Application.routes.draw do

	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)

	get 'auth/facebook/callback' => "users#facebookcallback"

	root 'pages#home'
	get 'tracker' => 'tracking#redirect', as: 'tracker'
	get '/mu-0e357f58-d55bbcb8-b75c6006-afc77dd7' => "pages#blitz"
	get '/loaderio-ca3765c7554fb9a08c649a0c6d43900f/' => "pages#loaderio"
	get 'link/:in_url' => 'shorteners#redirectlink'

	get 'api/setadblock', to: 'tracking#setadblock'
	get 'api/unsetadblock', to: 'tracking#unsetadblock'

	get 'howitworks', to: 'pages#newhowitworks', as: 'howitworks'
	get 'testimonials', to: 'pages#newtestimonials', as: 'testimonials'
	get 'legal/termsofservice', to: 'pages#docs_tos', as: 'docs_tos'
	get 'legal/privacypolicy', to: 'pages#docs_privacy', as: 'docs_privacy'

	get 'signup', to: 'users#new_signup', as: 'new_signup'
	get 'login', to: 'users#new_login', as: 'new_login'
	get 'start', to: 'users#login', as: 'login'
	post 'signup', to: 'users#createuser', as: 'post_signup'
	post 'login', to: 'sessions#create', as: 'post_login'
	get 'logout', to: 'sessions#logoutpage', as: 'get_logout'
	post 'logout', to: 'sessions#destroy', as: 'post_logout'
	get 'profile/forgotpassword', to: 'users#forgotpassword', as: 'forgotpassword'
	post 'profile/forgotpassword', to: 'users#resetpassword', as: 'resetpassword'

	get 'stores', to: 'stores#index', as: 'stores'
	get 'stores/:slug', to: 'stores#show', as: 'store'
	get 'stores/:slug/go', to: 'stores#visitstore', as: 'store_visit'
	get 'stores/:slug/visited', to: 'stores#visited', as: 'store_visited'
	get 'dashboard', to: 'users#dashboard', as: 'dashboard'
	get 'profile', to: 'users#show', as: 'profile'
	get 'profile/edit', to: 'users#edit', as: 'edit_profile'
	post 'profile/edit', to: 'users#update', as: 'update_profile'
	get 'profile/changepassword', to: 'users#changepassword', as: 'changepassword'
	post 'profile/changepassword', to: 'users#updatepassword', as: 'updatepassword'
	#get 'profile/destroy', to: 'users#destroy', as: 'delete_user'


	get 'orders/newamazon', to: 'orders#newamazon', as: 'newamazon'
	post 'orders/newamazon', to: 'orders#createamazon', as: 'createamazon'

	#get 'orders', to: 'orders#index', as: 'orders'
	#get 'orders/show/:id', to: 'orders#show', as: 'order'
	#get 'orders/edit/:id', to: 'orders#edit', as: 'edit_order'
	#post 'orders/edit/:id', to: 'orders#update', as: 'update_order'
	post 'orders/update_desc/:id', to: 'orders#update_desc', as: 'update_order_desc'
	post 'orders/delete/:id', to: 'orders#destroy', as: 'delete_order'

	#get 'orders/createrecharge', to: 'recharges#new', as: 'new_recharge'
	#post 'orders/createrecharge', to: 'recharges#create'
	#get 'orders/recharges/:id', to: 'recharges#show', as: 'recharge'
	#get 'orders/recharges/edit/:id', to: 'recharges#edit', as: 'edit_recharge'
	#post 'orders/recharges/edit/:id', to: 'recharges#update', as: 'update_recharge'
end

