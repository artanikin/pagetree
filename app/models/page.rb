class Page < ActiveRecord::Base
  has_ancestry

  validates :name,  uniqueness: true,
                    format: { with: /^[a-zA-Z\u0410-\u044F0-9_]+$/ }
  validates :name, :title, presence: true
end
