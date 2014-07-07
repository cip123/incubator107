require 'spec_helper'

describe "pasword reset" do


  let!(:city) { FactoryGirl.create(:city_with_links) }
  let!(:user) { FactoryGirl.create(:user) }

  describe "reset password" do

    
    before do
      visit url_for_subdomain "cluj", new_password_reset_path
       fill_in "email",         with: user.email
       click_button "Reset Password"
    end
    it "should send the pending mail" do
      reset_password_email = ActionMailer::Base.deliveries.last
      assert_equal "Password Reset", reset_password_email.subject
      assert_equal user.email, reset_password_email.to[0]   
      sub_string = /.*(http.*)\s.*/.match(reset_password_email.body.to_s)
      visit sub_string[0]
      

      fill_in "Password",     with: "foobar"
      fill_in "Password confirmation", with: "foobar"
      click_button "Update Password"

      fill_in "Email",     with: user.email
      fill_in "Password", with: "foobar"
      click_button "Sign in"

      expect(page).to have_title("Admin")
      

    end

  end

end
