module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ActAsApiRequest

      before_action :check_auth_header
      skip_after_action :verify_authorized, only: :status

      layout false
      respond_to :json

      rescue_from Exception,                           with: :render_error
      rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      rescue_from ActionController::RoutingError,      with: :render_not_found
      rescue_from AbstractController::ActionNotFound,  with: :render_not_found
      rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing
      rescue_from Pundit::NotAuthorizedError,          with: :render_not_authorized

      def status
        render json: { online: true }
      end

      private

      def current_user
        @current_user ||= if user_id_passed?
                            User.find_by(external_id: user_id)
                          elsif api_key_passed?
                            AdminUser.find_by(api_key: api_key)
                          end
      end

      def user_id
        request.headers[:userId]
      end

      def user_id_passed?
        user_id.present?
      end

      def api_key
        request.headers[:apiKey]
      end

      def api_key_passed?
        api_key.present?
      end

      def check_auth_header
        return if user_id_passed? || api_key_passed?

        if !user_id_passed? && !api_key_passed?
          render_parameter_missing(Exception.new('missing user_id header'))
        elsif !api_key_passed?
          render_parameter_missing(Exception.new('missing api_key header'))
        end
      end

      def render_error(exception)
        raise exception if Rails.env.test?

        # To properly handle RecordNotFound errors in views
        return render_not_found(exception) if exception.cause.is_a?(ActiveRecord::RecordNotFound)

        logger.error(exception) # Report to your error managment tool here

        return if performed?

        render json: { error: I18n.t('api.errors.server') }, status: :internal_server_error
      end

      def render_not_found(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.errors.not_found') }, status: :not_found
      end

      def render_record_invalid(exception)
        logger.info(exception) # for logging
        render json: { errors: exception.record.errors.as_json }, status: :bad_request
      end

      def render_parameter_missing(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
      end

      def render_not_authorized(exception)
        logger.info(exception)
        render json: { error: I18n.t('api.errors.unauthorized_action_on_resource') },
               status: :forbidden
      end
    end
  end
end
