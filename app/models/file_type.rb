class FileType < ApplicationRecord
  has_many :shared_files

  validates :name, presence: true
end
