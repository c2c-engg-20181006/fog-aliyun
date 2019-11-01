# frozen_string_literal: true

module Fog
  module Compute
    class Aliyun
      class Real
        # Disassociate an avalable eip IP address to the given instance.
        #
        # ==== Parameters
        # * server_id<~String> - id of the instance
        # * allocationId<~String> - id of the EIP
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'RequestId'<~String> - Id of the request
        #
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.201.106.DGkmH7#/pub/ecs/open-api/network&associateeipaddresss]
        def unassociate_eip_address(server_id, allocationId)
          _action = 'UnassociateEipAddress'
          _sigNonce = randonStr
          _time = Time.new.utc

          _parameters = defalutParameters(_action, _sigNonce, _time)
          _pathURL = defaultAliyunUri(_action, _sigNonce, _time)

          _parameters['InstanceId'] = server_id
          _pathURL += '&InstanceId=' + server_id

          _parameters['AllocationId'] = allocationId
          _pathURL += '&AllocationId=' + allocationId

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
