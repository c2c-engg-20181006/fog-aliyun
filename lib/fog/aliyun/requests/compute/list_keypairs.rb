#keypair added
module Fog
  module Compute
    class Aliyun
      class Real
        def list_keypairs(options = {})
          action = 'DescribeKeyPairs'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['RegionId'] = @aliyun_region_id
          pathUrl += '&RegionId='
          pathUrl += @aliyun_region_id

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
