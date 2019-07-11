# frozen_string_literal: true

module Fog
  module Compute
    class Aliyun
      class Real
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/vswitch&modifyvswitchattribute]
        def modify_disk(diskId, options = {})
          action = 'ModifyDiskAttribute'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['DiskId'] = diskId
          pathUrl += '&DiskId='
          pathUrl += URI.encode(diskId, '/[^!*\'()\;?:@#&%=+$,{}[]<>`" ')
          name = options[:name]
          desc = options[:description]

          if name
            parameters['DiskName'] = name
            pathUrl += '&DiskName='
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
