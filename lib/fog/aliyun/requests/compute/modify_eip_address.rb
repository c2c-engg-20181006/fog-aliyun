# frozen_string_literal: true

module Fog
  module Compute
    class Aliyun
      class Real
        # Modify an eip IP address.
        #
        # ==== Notes
        # The new eip Ip address would be available
        # The Modify eip Ip address can only associate to the instance of the vpc in the same region
        # Now the eip can support ICMP,TCP,UDP
        # ==== Parameters
        # * server_id<~String> - id of the instance
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'EipAddress'<~String> - the allocated eip address
        #     * 'RequestId'<~String> - Id of the request
        #
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.201.106.DGkmH7#/pub/ecs/open-api/network&modifyeipaddress]
        def modify_eip_address(allocationId, options = {})
          _action = 'ModifyEipAddressAttribute'
          _sigNonce = randonStr
          _time = Time.new.utc

          _parameters = defalutParameters(_action, _sigNonce, _time)
          _pathURL = defaultAliyunUri(_action, _sigNonce, _time)

          _parameters['AllocationId'] = allocationId
          _pathURL += '&AllocationId=' + allocationId

          # optional parameters
          _Bandwidth = options[:bandwidth]

          if _Bandwidth
            _parameters['Bandwidth'] = _Bandwidth
            _pathURL += '&Bandwidth=' + _Bandwidth
          end

          _signature = sign(@aliyun_accesskey_secret, _parameters)
          _pathURL += '&Signature=' + _signature

          request(
              expects: [200, 204],
              method: 'GET',
              path: _pathURL
          )
        end
      end
    end
  end
end
