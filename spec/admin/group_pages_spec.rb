require 'spec_helper'

describe "Event" do

  describe "configuration" do 

    let(:resource_class) { Group }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured" do
      expect(ActiveAdmin.application.namespaces[:admin].resources["Group"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let!(:group_a) { FactoryGirl.create(:group, name: "Group A") }
    let!(:group_b) { FactoryGirl.create(:group, name: "Group B") }

    let(:group_nodes) { page.all("#index_table_groups > tbody > tr") }
    let(:login) { 
      fill_in "admin_user_email", :with => 'admin@incubator107.com'
      fill_in "admin_user_password" , :with => "password"
      click_button :Login
    }

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
    end


    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/groups"
        login 
      end

      it "should display all the news" do
        expect(group_nodes[0]).to have_content("Group B")
        expect(group_nodes[1]).to have_content("Group A")  
      end

      it "should order by id" do
        click_link('Id')

        expect(group_nodes[0]).to have_content("Group A")
        expect(group_nodes[1]).to have_content("Group B")  
      end

      it "should order by Name" do
        click_link('Name')

        expect(group_nodes[0]).to have_content("Group A")
        expect(group_nodes[1]).to have_content("Group B")  
      end

      it "should delete a group", js: true do
        alert_text = page.accept_confirm do
          within group_nodes[0] do
            click_link "Delete"
          end
        end

        expect(Group.count).to eq(1)
      end

      it "should create a group", js: true do
        click_link "New Group"
        fill_in "group_name", with: "test"
        click_button "Create Group" 

        # we make sure the page is loaded
        expect(page).to have_content("Group Details")
        group = Group.find(3)
        expect(group.name).to eq("test")

      end
    end


    describe "view" do

      before do
           visit url_for_subdomain :cluj, "/admin/groups/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('Group A')
      end

      it "should update a group article", js: true do      
        click_link "Edit Group"
        fill_in "group_name", with: "test"
        click_button "Update Group" 

        # we make sure the page is loaded
        expect(page).to have_content("Group Details")
        group = Group.find(1)
        expect(group.name).to eq("test")
      end

    end

  end

end
