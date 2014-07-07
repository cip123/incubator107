require 'spec_helper'

describe "Authentication" do

  let!(:city) { FactoryGirl.create(:city)}

  describe "signin page" do
    before { visit url_for_subdomain "cluj", signin_path }
    it "should have the correct elements" do
      expect(page).to have_content('Sign in')
      expect(page).to have_title('Sign in')
    end
  end

  describe " with invalid information" do
    before do
      visit url_for_subdomain "cluj", signin_path
      click_button "Sign in"
    end

    it "should redirect to the same page when error" do
      expect(page).to have_title('Sign in')
      expect(page).to have_selector('div.alert.alert-error')
    end

  end

  describe "with valid information" do

    let (:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    it "should redirect to the home page" do
      expect(page).to have_link('Users', href: users_path)
      expect(page).to have_link('Profile', href:  user_path(user))
      expect(page).to have_link('Settings', href: edit_user_path(user))
      expect(page).to have_link('Sign out', href: signout_path)
      expect(page).not_to have_link('Sign in', href: signin_path)
    end

    describe "followed by signout" do
      before { click_link "Sign out" }
      it "should redirect to the admin page" do
        expect(page).to have_link('Sign in')
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do

      let!(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do

        before do
          visit url_for_subdomain "cluj", edit_user_path(user)          
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        it "should render the desired protected page" do
          expect(page).to have_title('Admin')
        end
      end

      describe "in the users controller" do

        it "should redirect to root_path when visiting the edit page" do
          visit url_for_subdomain "cluj", edit_user_path(user)
          expect(page).to have_title('Sign in')
        end

        it "should redirect to admin home when submitting to the update action" do
          patch url_for_subdomain "cluj", user_path(user)
          expect(response).to redirect_to(signin_path)
        end

        it "should redirect to admin home visiting the user index" do
          visit url_for_subdomain "cluj", users_path
          expect(page).to have_title('Sign in')
        end
      end
    end
  end


    describe "as an admin for a different city" do
      
      before do        
        FactoryGirl.create(:city, domain: "brasov")
        @cluj_user = FactoryGirl.create(:local_admin_user) 
        sign_in @cluj_user, no_capybara: true
     end

      it "should redirect to sign in path when visiting another admin section" do

        get url_for_subdomain "brasov", edit_user_path(@cluj_user)   
        expect(response.body).not_to match(full_title('Edit user')) 
        expect(response).to redirect_to signin_path
      end

      describe "submitting a PATCH request to the Users#update action" do
        before do 
          wrong_user = FactoryGirl.create(:user)
          patch user_path(wrong_user) 
        end

        it "should redirect to the signin path" do
         expect(response).to redirect_to(signin_path) 
        end
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      it "should redirect to the root path when submitting a DELETE request to the Users#destroy action" do
        delete user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end



  # end







end
