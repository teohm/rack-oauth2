module Rack
  module OAuth2
    module Server
      class Token
        class AuthProvider < Abstract::Handler
          def call(env)
            @request  = Request.new(env)
            @response = Response.new(request)
            super
          end

          class Request < Token::Request
            attr_required :provider, :auth_token
            attr_optional :auth_secret

            def initialize(env)
              super
              @grant_type  = :auth_provider
              @provider    = params['provider']
              @auth_token  = params['auth_token']
              @auth_secret = params['auth_secret']
              attr_missing!
            end
          end

          class Response < Token::Response
            attr_optional :user_email

            def protocol_params
              hash = super
              hash[:user_email] = self.user_email
              hash
            end
          end
        end
      end
    end
  end
end