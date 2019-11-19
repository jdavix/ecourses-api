# frozen_string_literal: true

module Api
  module V1
    # Api::V1::ChaptersController
    # Main chapters requests
    class ChaptersController < ApplicationController
      before_action :authenticate_user!

      def index
        @chapters = Chapter.all.page(page).per(per_page)
        standard_response(data: @chapters,
                          serializer: ChapterSerializer,
                          status: 200)
      end

      def create
        @chapter = Chapter.new(chapter_params)

        # Below line helps to ensure users can't assign chapters to courses they don't own.
        @course = current_user.courses.find(chapter_params[:course_id])
        if @chapter.save
          standard_response(message: 'Chapter created successfully',
                            data: @chapter,
                            serializer: ChapterSerializer,
                            status: 201)
        else
          error_response(message: 'Chapter could not be saved',
                         fields_errors: @chapter.errors_hash,
                         status: 422)
        end
      end

      def update
        if chapter.update_attributes(chapter_params)
          standard_response(message: 'Chapter created successfully',
                            data: chapter,
                            serializer: ChapterSerializer)
        else
          error_response(message: 'Chapter could not be saved',
                         fields_errors: chapter.errors_hash,
                         status: 422)
        end
      end

      private

      def chapter_params
        params.require(:chapter).permit(:title, :course_id)
      end

      def chapter
        @chapter ||= Chapter.find(params[:id])
      end
    end
  end
end
