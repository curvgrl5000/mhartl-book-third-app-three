require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end
  
  describe "Home page" do
    before {  visit root_path  }
    let(:heading)    {  'Sample App'  }
    let(:page_title) { '' }
    
    it_should_behave_like "all static pages"
    # it { should_not have_selector 'title', text: '| Home'} I added this in the view, so you have to delete the code in the view before you can uncomment this code.
  end
   
  describe "Help page" do
    before {  visit help_path  }
    let(:heading)    {  'Help'  }
    let(:page_title) { '' }
    
    it_should_behave_like "all static pages"
  end    

  describe "About page" do
    before {  visit about_path  }
    let(:heading)    {  'About'  }
    let(:page_title) { '' }
  end

  describe "Contacts page" do
    before {  visit contact_path  }
    let(:heading)    {  'Contact'  }
    let(:page_title) { '' }
  end
  
  describe "Tutorials page" do
    it "should have the content 'Tutorials' " do
      visit '/static_pages/tutorials'
      page.should have_content('Tutorials')
    end
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign Up')
    click_link "sample app"
    page.should have_selector 'title', id: full_title('')
  end
  
  describe "signup page" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",           with: "Example User"
        fill_in "Email",          with: "user@example.com"
        fill_in "Password",       with: "foobar"
        fill_in "Confirmation",   with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end 
                           