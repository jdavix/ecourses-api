# frozen_string_literal: true

module Api
  module V1
    # Api::V1::ContentsController
    # Main contents requests
    class ContentsController < ApplicationController
      before_action :authenticate_user!

      def index
        @contents = Content.all.includes(:content_file).page(page).per(per_page)
        standard_response(data: @contents,
                          serializer: ContentSerializer,
                          status: 200)
      end

      def create
        check_chapter!
        @content = Content.new(content_params)
        if @content.save
          standard_response(message: 'Content created successfully',
                            data: @content,
                            serializer: ContentSerializer,
                            status: 201)
        else
          error_response(message: 'Content could not be saved',
                         fields_errors: @content.errors_hash,
                         status: 422)
        end
      end

      def update
        check_chapter!
        if content.update_attributes(content_params)
          standard_response(message: 'Content created successfully',
                            data: content,
                            serializer: ContentSerializer)
        else
          error_response(message: 'Content could not be saved',
                         fields_errors: content.errors_hash,
                         status: 422)
        end
      end

      private

      def content_params
        params.require(:content).permit(:title,
                                        :content_type,
                                        :chapter_id,
                                        content_file: [:file])
      end

      def content
        @content ||= Content.find(params[:id])
      end

      def check_chapter!
        return nil unless params[:content][:chapter_id].present?
        @chapter = current_user.courses.joins(:chapters).find(params[:content][:chapter_id])
      end
    end
  end
end
