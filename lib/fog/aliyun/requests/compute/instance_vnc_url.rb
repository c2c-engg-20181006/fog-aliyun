#for accessing vnc console
module Fog
  module Compute
    class Aliyun
      class Real
        def instance_vnc_url(_InstanceId)
          action = 'DescribeInstanceVncUrl'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['InstanceId'] = _InstanceId
          pathUrl += '&InstanceId='
          pathUrl += _InstanceId

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
