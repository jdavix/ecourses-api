class ContentFile < ApplicationRecord
  include ErrorHash

  belongs_to :content

  # Link content file to course for referencing on future contents creation.
  belongs_to :course, optional: true

  mount_uploader :file, ContentFileUploader
end
