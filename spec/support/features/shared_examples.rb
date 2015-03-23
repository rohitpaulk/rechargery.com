module Features
  module SharedExamples
    RSpec.shared_examples 'login wall redirect' do |url|
      scenario 'try to access ' + url do
        logout
        visit url
        expect(page.current_path).to eq("/login")
        within("//form[@action='/login']") do
          fill_in "Email", :with => @user.email
          fill_in "Password", :with => "abcd"
        end
        click_button "Login"
        expect(page.current_path).to eq(url)
      end
    end
  end
end
