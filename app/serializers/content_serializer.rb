class ContentSerializer < BaseSerializer
  attributes :title, :content_type, :created_at, :updated_at

  attribute :content_file_url do |c|
    c.content_file&.file&.to_s
  end
  attribute :html_text do |c|
    c.content_file&.html_text
  end
end
