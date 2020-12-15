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

      def pundit_user
        current_account
      end

      def current_account
        @current_account = api_key.present? ? Account.find_by(api_key: api_key) : nil
      end

      def current_user
        user_id = request.headers[:userId]
        @current_user = user_id.present? ? User.find_by(external_id: user_id) : nil
      end

      def user_id
        request.headers[:userId]
      end

      def api_key
        request.headers[:apiKey]
      end

      def auth_headers_passed?
        api_key.present? || user_id.present?
      end

      def check_auth_header
        render_unauthorized(Exception.new('missing auth headers')) unless auth_headers_passed?
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

      def render_unauthorized(exception)
        logger.info(exception)
        render json: { error: I18n.t('api.errors.unauthorized') },
               status: :unauthorized
      end
    end
  end
end
