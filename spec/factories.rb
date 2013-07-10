FactoryGirl.define do
	factory :page, aliases: [:pageobj] do
		name  "pagename"
		title "Title Page"
		description "Description Page"
		ancestry nil
	end
end