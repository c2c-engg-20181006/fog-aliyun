# frozen_string_literal: true
module Fog
  module Compute
    class Aliyun
      class Real
        def modify_security_group(securityGroupId,options = {})
          action = 'ModifySecurityGroupAttribute'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['SecurityGroupId'] = securityGroupId
          pathUrl += '&SecurityGroupId=' + securityGroupId
          name = options[:name]
          desc = options[:description]

          if name
            parameters['SecurityGroupName'] = name
            pathUrl += '&SecurityGroupName='
            pathUrl += name
          end

          if desc
            parameters['Description'] = desc
            pathUrl += '&Description='
            pathUrl += desc
          end

		  signature = sign(@aliyun_accesskey_secret, parameters)
          pathUrl += '&Signature='
          pathUrl += signature
		  
          request(
              expects: [200, 203],
              method: 'GET',
              path: pathUrl
          )
        end
      end
    end
  end
end
