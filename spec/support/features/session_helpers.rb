module Features
	module SessionHelpers
		def sign_in_with(email,password)
			visit "/login"
			within("//form[@action='/login']") do
				fill_in "email", :with => email
				fill_in "password", :with => password
			end
			click_button "Login"
		end

		def sign_up_with(name,email,password,password_confirmation,phone,operator)
			visit "/signup"
			within("//form[@action='/signup']") do
				fill_in "email", :with => email
				fill_in "password", :with => password
				fill_in "password_confirmation", :with => password_confirmation
				fill_in "phone", :with => phone
				fill_in "name", :with => name
				select "Airtel", :from => "phoneoperator-input"
			end
			click_button "Signup"
		end

		def logout
			visit "/logout"
			within "#wrapper1" do
				click_link "Log Out"
			end
		end
	end
end
