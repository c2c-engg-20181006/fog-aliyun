# frozen_string_literal: true
module Fog
  module Compute
    class Aliyun
      class Real
        def create_vswitch(cidrBlock, vpcId, zoneId, options = {})
          # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/vswitch&createvswitch]
          action = 'CreateVSwitch'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['CidrBlock'] = cidrBlock
          pathUrl += '&CidrBlock='
          pathUrl += URI.encode(cidrBlock, '/[^!*\'()\;?:@#&%=+$,{}[]<>`" ')

          parameters['VpcId'] = vpcId
          pathUrl += '&VpcId='
          pathUrl += vpcId

          parameters['ZoneId'] = zoneId
          pathUrl += '&ZoneId='
          pathUrl += zoneId

          parameters['RegionId'] = @aliyun_region_id
          pathUrl += '&RegionId='
          pathUrl += @aliyun_region_id

          name = options[:name]
          desc = options[:description]

          if name
            parameters['VSwitchName'] = name
            pathUrl += '&VSwitchName='
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
