# frozen_string_literal: true
module Fog
  module Compute
    class Aliyun
      class Real
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/securitygroup&authorizesecuritygroup]
        def create_security_group_egress_ip_rule(securitygroup_id, cidrIp, option = {})
          action = 'AuthorizeSecurityGroupEgress'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['SecurityGroupId'] = securitygroup_id
          pathUrl += '&SecurityGroupId='
          pathUrl += securitygroup_id

          #destCiderIp replace with cidrIp
          parameters['DestCidrIp'] = cidrIp
          pathUrl += '&DestCidrIp='
          pathUrl += URI.encode(cidrIp, '/[^!*\'()\;?:@#&%=+$,{}[]<>`" ')

          nicType = option[:nicType]
          nicType ||= 'intranet'
          parameters['NicType'] = nicType
          pathUrl += '&NicType='
          pathUrl += nicType

          port = option[:port]
          endport =option[:endport]
          port ||= '-1'
          endport ||= '-1'
          parameters['PortRange'] = port+'/'+endport
          pathUrl += '&PortRange='
          pathUrl += URI.encode(port+'/'+endport, '/[^!*\'()\;?:@#&%=+$,{}[]<>`" ')

          protocol = option[:protocol]
          protocol ||= 'all'
          parameters['IpProtocol'] = protocol
          pathUrl += '&IpProtocol='
          pathUrl += protocol

          policy = option[:policy]
          policy ||= 'accept'
          parameters['Policy'] = policy
          pathUrl += '&Policy='
          pathUrl += policy

          priority = option[:priority]
          priority ||= '1'
          parameters['Priority'] = priority
          pathUrl += '&Priority='
          pathUrl += priority

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
