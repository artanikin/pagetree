# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  ancestry    :string(255)
#

require 'spec_helper'

describe Page do

	before { @page = Page.new(name: 'ExampleName01', title: 'ExTitle01', description: 'DS01') }  

	subject { @page }

	it { should respond_to(:name) }
	it { should respond_to(:title) }
	it { should respond_to(:description) }

	it { should be_valid }

	describe "when name is not present" do
		before { @page.name = "" }
		it { should_not be_valid }
	end

	describe "when title is not present" do
		before { @page.title = "" }
		it { should_not be_valid }
	end

	describe "when description is not present" do
		before { @page.description = "" }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @page.name = 'w'*31 }
		it { should_not be_valid }
	end

	describe "when name format is invalid" do
		it "should be invalid" do
			names = %w['' .. name.. \u0410u0411u0412! name@
								name# (name) name% $name; name, name*]
			names.each do |invalid_name|
				@page.name = invalid_name
				@page.should_not be_valid
			end
		end
	end

	describe "when name format is valid" do
		it "should be valid" do
			names = %w[name name01 name_01] 
			names.each do |valid_name|
				@page.name = valid_name
				@page.should be_valid
			end
		end
	end

	describe "when name is already taken" do
		before do
			page_with_same_name = @page.dup
			page_with_same_name.name = @page.name.upcase
			page_with_same_name.save
		end
		it { should_not be_valid }
	end

	describe "name with mixed case" do
		let (:mixed_case_name) { "NaMe01" }

		it "should be saved as all lower-case" do
			@page.name = mixed_case_name
			@page.save
			@page.reload.name.should == mixed_case_name.downcase
		end
	end

end
