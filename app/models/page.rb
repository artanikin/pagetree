class Page < ActiveRecord::Base
  has_ancestry
	
	VALID_NAME_REGEX = /^[a-zA-Z\u0410-\u044F0-9_]+$/
  validates :name,  uniqueness: { case_sensitive: false },
                    format: { with: VALID_NAME_REGEX }
  validates :name, :title, presence: true
end
