# frozen_string_literal: true

module Api
  module V1
    # Api::V1::CoursesController
    # Main courses requests
    class CoursesController < ApplicationController
      before_action :authenticate_user!

      def index
        @courses = Course.all.page(page).per(per_page)
        standard_response(message: nil, data: @courses, status: 200, serializer: CourseSerializer)
      end

      def create
        @course = Course.new(course_params)
        @course.user = current_user
        if @course.save
          standard_response(message: 'Course created successfully', data: @course,
                                                           serializer: CourseSerializer,
                                                           status: 201)
        else
          error_response(message: 'Course could not be saved', fields_errors: @course.errors_hash,
                                                      status: 422)
        end
      end

      def update
        if course.update_attributes(course_params)
          standard_response(message: 'Course created successfully', data: course,
                                                           serializer: CourseSerializer)
        else
          error_response(message: 'Course could not be saved', fields_errors: course.errors_hash,
                                                      status: 422)
        end
      end

      private

      def course_params
        params.require(:course).permit(:name, :subtitle,
                                       :description, :price,
                                       :duration)
      end

      def course
        @course ||= Course.find(params[:id])
      end
    end
  end
end
