module GithubApps
  class RequestValidator
    attr_reader :request, :result

    def self.call(*args)
      new(*args).call
    end

    def initialize(request)
      @request = request
      @result = Result.new
    end

    def call
      if valid_webhook_signature?
        authenticate_installation
      end

      result.payload = payload
      result
    end

    private

    def valid_webhook_signature?
      return true unless webhook_secret.present?

      their_signature_header = request.env['HTTP_X_HUB_SIGNATURE'] || 'sha1='
      method, their_digest = their_signature_header.split('=')
      our_digest = OpenSSL::HMAC.hexdigest(method, webhook_secret, raw_payload)

      their_digest == our_digest || invalid_webhook_signature!
    end

    def invalid_webhook_signature!
      result.error! 401, "Invalid webhook secret digest provided"

      false
    end

    def authenticate_installation
      return unless payload['installation']
      installation_id = payload['installation']['id']
      installation_token = GithubApps.app_client.create_app_installation_access_token(installation_id)[:token]
      result.client = Octokit::Client.new(bearer_token: installation_token)
    rescue JSON::ParserError
      result.error! 400, "Request body contained invalid JSON"
    end

    def webhook_secret
      GithubApps.config.webhook_secret
    end

    def raw_payload
      @_raw_payload ||= begin
        request.body.rewind
        request.body.read
      end
    end

    def payload
      @_payload ||= JSON.parse(raw_payload)
    end

    class Result
      attr_accessor :error, :client, :payload

      def initialize()
      end

      def success?
        !error
      end

      def error!(status, message)
        self.error = {
          json: { message: message }, status: status
        }
      end
    end


  end
end