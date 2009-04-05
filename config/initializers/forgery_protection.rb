module ActionController
  module RequestForgeryProtection
    
    def verify_authenticity_token
      verified_request? || block_user! || raise(ActionController::InvalidAuthenticityToken)
    end
      
    def block_user!
      BlockedIp.unverified_request!(request.remote_ip)
    end
    
  end
  
end