require 'spec_helper'

describe "User pages" do

  let!(:city) { FactoryGirl.create(:city) }

  describe "signup" do

    before { visit url_for_subdomain "cluj", signup_path }

    let(:submit) { "Create my account" }

    it "should have the correct elements" do
      expect(page).to have_content('Sign Up')
      expect(page).to have_title(full_title('Sign Up'))
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end


      describe "after saving the user" do
        before { click_button submit }

        let(:user) { User.find_by(email: 'user@example.com') }

        # TODO redirect to the main page
        it "should redirect to the user page" do
          expect(page).to have_link('Sign out')
          expect(page).to have_title(user.name)
          expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
        end
      end
    end
  end


  describe "index" do
    let(:user) { FactoryGirl.create(:super_admin_user) }

    before do
      sign_in user
      visit url_for_subdomain "cluj", users_path
    end

    it "should list the users page" do
      expect(page).to have_content('All users')
      expect(page).to have_title('All users')
    end

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it "should list each user" do
        expect(page).to have_selector('div.pagination')
        expect(page).to have_selector('div.pagination')
        User.paginate(page: 1).each do |user|
          expect(page).to have_link(user.name, href: edit_user_path(user))
        end
      end
    end
  end

  describe "as a regular user" do

    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit url_for_subdomain "cluj", profile_path(user)
    end

    it "should be able to able to delete its account" do

      expect(page).to have_button('Delete account')

      expect do
        click_button('Delete account', match: :first)
      end.to change(User, :count).by(-1)
    end

    describe "edit page" do

      it "should display the correct edit page" do
        expect(page).to have_content("Update your profile")
        expect(page).to have_title("Update your profile")
      end

      describe "with invalid information" do
        before do
           fill_in "Password",         with: "1"
          click_button "Save changes"
        end

        it "should display an error" do
          
          expect(page).to have_content('error')
        end
      end

      describe "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirm Password", with: user.password
          click_button "Save changes"
        end

        it "should display the updated home page" do
          expect(page).to have_title(new_name)
          expect(page).to have_selector('div.alert.alert-success')
          expect(page).to have_link('Sign out', href: signout_path)
          expect(user.reload.name).to  eq new_name
          expect(user.reload.email).to eq new_email
        end
      end
    end
  end

  describe "as an admin user" do

    let!(:user) { FactoryGirl.create(:user) }
    let!(:local_admin) { FactoryGirl.create(:local_admin_user) }    
    let!(:super_admin) { FactoryGirl.create(:super_admin_user) }

    before do      
      sign_in super_admin
      visit url_for_subdomain "cluj", edit_user_path(local_admin)
    end

    describe "edit page" do

      it "should display the correct edit page" do
        
        expect(page).to have_content("Edit user")
        expect(page).to have_title("Edit user")
        expect(page).to have_button("Delete account")
        expect(page).to have_button("Reset password")
        expect(page).to have_select('user_role', selected: 'Local admin')
        expect(page).to have_content("Local admin")
      end

      it "should be able to able to delete the account" do      
        city.users << local_admin

        expect do
          click_button('Delete account', match: :first)
        end.to change(User, :count).by(-1)

        city.reload
        expect(city.users).not_to include(local_admin)
      end


      it "should upgrade local to super" do

        city.users << local_admin
        select('Admin', :from => 'user_role')
        click_button "Save changes"
        
        expect(page).to have_select('user_role', selected: 'Admin')
        city.reload
        puts city.users.inspect
        expect(city.users).not_to include(local_admin)

      end

      it "should upgrade regular to local admin" do
        visit url_for_subdomain "cluj", edit_user_path(local_admin)

        select('Local admin', :from => 'user_role')
        click_button "Save changes"
        
        expect(page).to have_select('user_role', selected: 'Local admin')
        city.reload
        expect(city.users).to include(local_admin)

      end


    end
  end


end
