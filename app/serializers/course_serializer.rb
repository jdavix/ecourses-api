class CourseSerializer < BaseSerializer
  attributes :name, :subtitle, :description,
             :price, :duration, :created_at,
             :updated_at
end
