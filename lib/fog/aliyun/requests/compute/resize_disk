# frozen_string_literal: true
module Fog
  module Compute
    class Aliyun
      class Real
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/vswitch&modifyvswitchattribute]
        def resize_disk(diskId, options = {})
          action = 'ResizeDisk'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['DiskId'] = diskId
          pathUrl += '&DiskId='
          pathUrl += URI.encode(diskId, '/[^!*\'()\;?:@#&%=+$,{}[]<>`" ')

          size = options[:size]

          if size.to_s
            parameters['NewSize'] = size.to_s
            pathUrl += '&NewSize='
            pathUrl += size.to_s
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
