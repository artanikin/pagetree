require 'spec_helper'

describe "Pages" do

	subject { page }

	describe "Home page" do
		before { visit pages_path }
		it { should have_selector('h1', text: 'Pagetree') }
	end

	describe "Show page" do
		let(:pageobj) { FactoryGirl.create(:pageobj) }
		before { visit show_page_path(pageobj.name) }

		it { should have_selector('h1', text: pageobj.title) }
	end

	describe "New page" do
		before { visit add_page_path }

		let(:submit) { "Save Page" }

		describe "with invalid information" do
			it "should not create page" do
				expect { click_button submit }.not_to change(Page, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",        with: "ExamplePageName"
				fill_in "Title",       with: "Example Title Page"
				fill_in "Description", with: "Example Description Page"
			end

			it "should create a page" do
				expect { click_button submit }.to change(Page, :count).by(1)
			end
		end
	end

	describe "Edit page" do
		let(:pageobj) { FactoryGirl.create(:pageobj) }
		let(:submit) { "Save Page" }

		before { visit edit_page_path(pageobj.name) }

		it { should have_selector('h1', text: 'Edit Page') }
	end

end
