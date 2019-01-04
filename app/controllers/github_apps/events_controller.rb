require_dependency "github_apps/application_controller"

module GithubApps
  class EventsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def receive
      result = RequestValidator.call(request)

      if result.success?
        RequestDelegator.call(
          request.env["HTTP_X_GITHUB_EVENT"],
          result.payload["action"],
          result.payload
        )
      else
        render result.error
      end
    end

    private

    def payload_params
      params.permit(:action)
    end
  end
end
