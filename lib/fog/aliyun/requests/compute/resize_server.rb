# frozen_string_literal: true
module Fog
  module Compute
    class Aliyun
      class Real
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/vswitch&modifyvswitchattribute]
        def resize_server(instanceId, instanceType)
          action = 'ModifyInstanceSpec'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['InstanceId'] = instanceId
          pathUrl += '&InstanceId='
          pathUrl += URI.encode(instanceId, '/[^!*\'()\;?:@#&%=+$,{}[]<>`" ')

          if instanceType
            parameters['InstanceType'] = instanceType
            pathUrl += '&InstanceType='
            pathUrl += instanceType
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
